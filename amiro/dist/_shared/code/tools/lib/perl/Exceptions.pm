
package ErrException;
use Error qw(:try);
use base qw(Error);



sub new {

    my $self = shift;
    my $msg = shift;
    my $code = shift;
    my $data = shift;
    
    local $Error::Depth = $Error::Depth+1;
    local $Error::Debug = 1;
    
    $self->SUPER::new(-myMsg=>$msg,-text=>'',-object=>$data,-code=>$code);

}


sub code {

    my $self = shift;
    exists $self->{'-code'} ? int($self->{'-code'}) : undef;
}

sub myMsg {
    my $self = shift;
    exists $self->{'-myMsg'} ? $self->{'-myMsg'} : undef;
}

sub stringify {
    my $self = shift;
    my $text = "\n".ref($self)." [Code: ".$self->code."]\n".$self->myMsg."\n\n".$self->stacktrace;
    
    $text;

}


package DBException;
use Error qw(:try);
use base qw(ErrException);


sub new {

    my $self = shift;
    my $msg = shift;
    my $code = shift;
    
    local $Error::Depth = $Error::Depth+1;
    local $Error::Debug = 1;
    
    $self->SUPER::new($msg,$code);

}


1;
