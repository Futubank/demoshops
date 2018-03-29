
package SI::CMS::SubsSender;

use Error qw(:try);
use Exceptions;
use SI::Utils;
use SI::Logger;
use SI::CMS::Utils;

sub new {

    my $class = shift;

    my $self = {};
    $self->{docroot} = shift;
    $self->{logger} = shift;

    $self->{sent} = $self->{failed} = 0;
    bless $self,$class;
}

sub log {
    my $self = shift;
    defined $self->{logger} && $self->{logger}->log(@_);
}


sub sendQueued {

    my $self = shift;

    $self->log("START $self->{docroot}",LL_NOTE);
    my $cfg = SI::CMS::Utils::siteConfig($self->{docroot});
    my $dbh = SI::CMS::Utils::siteDBConnection($cfg);
    $dbh->do("SET NAMES $cfg->{DB_ConnectionCharset}") if defined $cfg->{DB_ConnectionCharset};

    my $sthu = $dbh->prepare("UPDATE cms_subs_sent SET attempts_left=?, log=? WHERE id=?");
    my $sql = "SELECT id, attempts_left, log, body, headers ".
       "FROM cms_subs_sent WHERE attempts_left>0 ORDER BY id asc";
    my $sth = $dbh->select($sql);

    while (my @res = $sth->fetchrow_array()) {
        my $log = $res[2];
        my $body = $res[3];
        my $outLog = '';

        if($log =~ /^(Queued date:.*?\n).*?Details:(.*?)End of details/s) {
            # Not a first attempt to send letters
            $outLog = $1;
            $outLog .= $self->_sendMails($dbh,$2,$body,$res[4]);
            $outLog .= $log;
        } else {
            # First attempt to send letters
            $self->log("Error in log format id=".$res[0],LL_WARN);
            $outLog = "";
        }

        my $attempts;
        if($self->{failed} == 0) {
            if($self->{sent} == 0) {
                $outLog = "";
            }
            $attempts = 0;
        } else {
            $attempts = $res[1] - 1;
        }

        $sthu->execute($attempts,$outLog,$res[0]);
    }

    $self->log("END $self->{docroot}",LL_NOTE);
}


sub _sendMails {

    my $self = shift;
    my ($dbh,$mailList,$body,$headers) = @_;
    my $logDetails = "";
    my %header;

    $self->{failed} = 0;
    $self->{sent} = 0;

    my @headersList = split(/[\r\n]/, $headers);
    foreach (@headersList) {
        $header{$1} = $2 if(/^(.*?):(.*)$/);
    }

    my $subj = $header{Subject};
    delete $header{Subject};
    $self->log("Send start: Subject='$subj'",LL_NOTE);
    my $log = "Send start date: ".formatDate()."\n";

    my @emails = split(/[\r\n]/, $mailList);
    foreach my $addr (@emails) {
        if($addr =~ / - Fail/) {
            $addr =~ s/ - Fail.*//;   # Remove Fail status
            my ($username,$firstname,$lastname) = 
                $dbh->getRecord('SELECT username,firstname,lastname FROM cms_members WHERE email=?',0,$addr);
            $pBody = $body;
            $pBody =~ s/__username__/$username/g;
            $pBody =~ s/__firstname__/$firstname/g;
            $pBody =~ s/__lastname__/$lastname/g;
            try {
                sendMail($addr,$subj,$pBody,\%header,'prog:sendmail');
                $self->log("Sent to '$addr'",LL_DEBUG);
                $self->{sent}++;
            } catch ErrException with {
                my $e = shift;
                $self->log("Cannot send to '$addr': ".$e->myMsg, LL_ERROR);
                $logDetails .= "$addr - Fail\n";
                $self->{failed}++;
            };
        }
    }

    $self->log("Send end: Subject='$header{Subject}', sent=$self->{sent}, err=$self->{failed}",LL_NOTE);

    $log .= "Send end date: ".formatDate()."\n";
    $log .= "Successfully sent to: ".$self->{sent}." subscriber(s)\n";
    $log .= "Failed to: ".$self->{failed}." subscriber(s)\n";
    $log .= "Details:\n".$logDetails."End of details.\n\n";

    return $log;
}



1;
