
package SI::IPC::FIFOServerConnection;

use Error qw(:try);
use Exceptions;
use POSIX;
use SI::Utils;
use Fcntl ':flock';

sub new {

    my $class = shift;
    my ($path,$to) = (shift,shift);
    $to = 10 if !defined $to;

    my $self = {
            fdIn => undef,
            fdOut => undef,
            fdLock =>undef,
            path =>$path,
            defTO => $to,
            isOpen => 0,
            fileIn => $path.'/sock.serv',
            fileOut => $path.'/sock.client'
        };
    bless $self,$class;
}


sub listen {

    my $self = shift;

    $self->_close();


}


# returns 0 on protocol error (no 'SYN')
sub accept {

    my $self = shift;

    -e $self->{fileIn} && unlink($self->{fileIn});
    -e $self->{fileOut} && unlink($self->{fileOut});

    POSIX::mkfifo($self->{fileIn},0666) || throw ErrException("Cannot create FIFO $self->{fileIn}: $!");
    chmod(0666,$self->{fileIn}) || throw ErrException("Cannot chmod 666 $self->{fileIn}: $!");
    POSIX::mkfifo($self->{fileOut},0666) || throw ErrException("Cannot create FIFO $self->{fileOut}: $!");
    chmod(0666,$self->{fileOut}) || throw ErrException("Cannot chmod 666 $self->{fileOut}: $!");

    open($self->{fdIn},"+<",$self->{fileIn}) || 
        throw ErrException("Cannot open FIFO $self->{fileIn}: $!");
    open($self->{fdOut},"+<",$self->{fileOut}) || 
        throw ErrException("Cannot open FIFO $self->{fileOut}: $!");

    my $rin='';
    my $rout='';
    vec($rin,fileno($self->{fdIn}),1)=1;
    my $nfound = select($rout=$rin,undef,undef,undef);
    !$nfound && throw ErrException("select() returned error: $!");
    $self->{isOpen} = 1;

    my $res = 1;
    try {
        my $data = $self->recv();
        if($data ne 'SYN') {
            $res = 0;
        } else {
            my $sLock = $self->{path}.'/serv.lock';
            $self->{fdLock} = openFile($sLock,'>');
            flock($self->{fdLock},LOCK_EX) || throw ErrException("Cannot flock $sLock");
            $self->send('ACK');
            $self->{finRecvd} = 0;
        }
    } catch ErrException with {
        my $e = shift;
        $self->_close();
        throw $e;
    };
    return $res;
}



sub send {

    my $self = shift;
    my $data = shift;
    my $to = shift;
    $to = $self->{defTO} if !defined $to;

    $self->{isOpen} || throw ErrException("No connection opened");

    $data = $self->_escape($data)."\n";
    my $timeleft = $to;
    my $start = time();
    my $rin='';
    my $rout='';
    my $res = 0;
    vec($rin,fileno($self->{fdOut}),1)=1;
    try {
        while(select(undef,$rout=$rin,undef,$timeleft)) {

            my $nbytes = syswrite($self->{fdOut},$data);
            !defined $nbytes &&
                throw ErrException("syswrite() returned error");
            $data = substr($data,$nbytes);
            if(!length($data)) {
                $res = 1;
                last;
            }
            
            $timeleft = $to-(time()-$start);
            $timeleft <= 0 && last;
        }
    } catch ErrException with {
        my $e = shift;
        $self->_close();
        throw $e;
    };
    if(!$res) {
        $self->_close();
        throw ErrException("Cannot write to pipe: timeout");
    }
}

sub recv {

    my $self = shift;
    my $to = shift;
    $to = $self->{defTO} if !defined $to;
    $self->{isOpen} || throw ErrException("No connection opened");
    my $timeleft = $to;
    my $start = time();
    my $rin='';
    my $rout='';
    my $data = '';
    my $res = 0;
    vec($rin,fileno($self->{fdIn}),1)=1;
    try {
        while(select($rout=$rin,undef,undef,$timeleft)) {
            my $buf;
            my $nbytes = sysread($self->{fdIn},$buf,1024);
            !defined $nbytes &&
                throw ErrException("sysread() returned error");
            $data .= $buf;
            if($data =~ s/\n$//) {
                $data = $self->_escape($data,0);
                $res = 1;
                if($data eq 'FIN') {
                    $self->_close();
                    $self->{finRecvd} = 1;
                    $data = undef;
                }
                last;
            }

            $timeleft = $to-(time()-$start);
            $timeleft<=0 && last;
        }
    } catch ErrException with {
        my $e = shift;
        $self->_close();
        throw $e;
    };
    if(!$res) {
        $self->_close();
        throw ErrException("Cannot read from pipe: timeout");
    }
    return $data;
}


sub _close {

    my $self = shift;
    $self->{isOpen} = 0;
    close($self->{fdIn});
    close($self->{fdOut});
    -e $self->{fileIn} && unlink($self->{fileIn});
    -e $self->{fileOut} && unlink($self->{fileOut});
    close($self->{fdLock});
}

sub close {

    my $self = shift;
    $self->_close();
}


sub shutdown {

    my $self = shift;
    $self->_close();
}

sub _escape {

    my $self = shift;
    my $data = shift;
    my $on = shift;
    $on = 1 if !defined $on;

    if($on) {
        $data =~ s/\\/\\\\/gs;
        $data =~ s/\n/\\n/gs;
    } else {
        $data =~ s/\\n/\n/gs;
        $data =~ s/\\\\/\\/gs;
    }

    return $data;
}


1;
