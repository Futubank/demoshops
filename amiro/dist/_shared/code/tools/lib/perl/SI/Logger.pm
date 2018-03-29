#!/usr/bin/perl


package SI::Logger;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(LL_CRIT LL_ERROR LL_WARN LL_NOTE LL_DEBUG logLevel);

use SI::Utils;
#use Data::Dumper;
#use Error qw(:try);
#use Exceptions;


sub LL_CRIT { 50; }
sub LL_ERROR { 40; }
sub LL_WARN { 30; }
sub LL_NOTE { 20; }
sub LL_DEBUG { 10; }

sub logLevel {

    my $levStr = shift;
    my %lvl = ('CRIT'=>LL_CRIT,'ERROR'=>LL_ERROR,'WARN'=>LL_WARN,'NOTE'=>LL_NOTE,'DEBUG'=>LL_DEBUG);
    !exists $lvl{$levStr} && return LL_DEBUG;
    return $lvl{$levStr};
}


#use constant {

#    LL_CRIT => 50,
#    LL_ERROR => 40,
#    LL_WARN => 30,
#    LL_NOTE => 20,
#    LL_DEBUG => 10
#};


BEGIN {

    $LEVELS[LL_CRIT] = 'CRIT';
    $LEVELS[LL_ERROR] = 'ERROR';
    $LEVELS[LL_WARN] = 'WARN';
    $LEVELS[LL_NOTE] = 'NOTE';
    $LEVELS[LL_DEBUG] = 'debug';
}


sub new {

	my $class = shift;
	my $self = {};
	$self->{_logFile} = shift;
	$self->{_level} = shift;
    $self->{_level} = 0 if !defined $self->{_level};
	$self->{_save} = shift;
    $self->{_events} = [];
    $self->{_maxLevel} = $self->{_saveLevel} = 0;
    bless $self,$class;

}



sub openLog {

	my $self = shift;
	if(!defined $self->{_fd} && defined $self->{_logFile}) {
        $self->{_fd} = openFile($self->{_logFile},'>>');
        my $ofd = select($self->{_fd});
        $| = 1;
        select ($ofd);
	}
}

sub closeLog {

	my $self = shift;
	if(defined $self->{_fd}) {
		close($self->{_fd});
	}
	return 1;
}


sub log {

    my $self = shift;
	my $msg = shift;
	my $level = shift;


    $level = LL_DEBUG if !defined $level;
	my ($sec,$min,$hour,$day,$mon,$year) = localtime();
	my $str = sprintf("%04d.%02d.%02d %02d:%02d:%02d % 5d %- 8s $msg",$year+1900,$mon+1,$day,$hour,$min,$sec,$$,
        '['.$LEVELS[$level].']');
    $self->{_maxLevel} = $level if $level>$self->{_maxLevel};

    if($self->{_save} && $level>=$self->{_saveLevel}) {
        my $hr = $self->{_events};
        push(@$hr,"**   $str");
    }

    $level<$self->{_level} && return;

    $self->openLog();
	if(defined $self->{_fd}) {
        my $fd = $self->{_fd};
		print $fd "$str\n";;
	} else {
		print STDERR "$str\n";;
	}
}


sub logException {
    
    my $self = shift;
    my ($ex,$msg,$level) = @_;
    $level = LL_ERROR if !defined $level;

    $self->log("$msg\n$ex",$level);

}

sub save {

    my $self = shift;
    my $doSave = shift;
    my $level = shift;
    $level = 0 if !defined $level;
    $doSave = 1 if !defined $doSave;

    $self->{_save} = $doSave;
}

sub historyAsText {
    
    my $self = shift;
    my ($maxLevel,$stop,$purge) = @_;
    $maxLevel = 0 if !defined $maxLevel;
    $stop = 1 if !defined $stop;
    $purge = 1 if !defined $purge;

    my $hr = $self->{_events};
    my $txt = '';
    foreach my $ev (@$hr) {
        $txt .= "$ev\n";
    }
    $self->save(!$stop);
    if($purge) {
        $self->{_events} = [];
        $self->{_maxLevel} = 0;
    }

    return $txt;
}


sub maxHistoryLevel {

    my $self = shift;
    return $self->{_maxLevel};
}

sub resetHistoryLevel { my $self = shift; $self->{_maxLevel} = 0; }

1;
