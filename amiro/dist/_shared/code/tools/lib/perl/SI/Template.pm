
package SI::Template;

use Error qw(:try);
use Exceptions;
use SI::Utils;

sub new {
    my $class = shift;
    my $self = { };
    $self->{regexp}{comment} = qr/##--.*?--##[\r]?[\n]?/s;
    $self->{regexp}{set} = qr/(<!--#set +((?:GS)|(?:GD))?var=")([a-zA-Z0-9_;]+)(" +value=")(.*?)("\s*-->)([\r]?[\n]?)/si;
    $self->{block} = {};
    bless $self;
    return $self;
}


sub addBlock {

    my $self = shift;
    my $name = shift;
    my $file = shift;
    my $text;

    try {
        $text = readFile($file);
    } catch ErrException with {
    };
    !defined $text && return;
    # remove comments
    $text =~ s/$self->{regexp}{comment}//g;
    # variables
    while($text =~ $self->{regexp}{set}) {
        $self->{block}{$name}{$3} = $5;
        $text = $`.$';
    }
    $self->{block}{$name}{body} = $text;
}


sub get {

    my $self = shift;
    my $key = shift;
    my $data = shift;
    my ($tpl,$k);

    my ($block,$var) = split(/:/,$key);
    if(!$var) { $var = 'body'; }
    $tpl = $self->{block}{$block}{$var};
    foreach $k (keys(%$data)) {
        $tpl =~ s/##$k##/$$data{$k}/sg;
    }
    # remove unset vars
    $tpl =~ s/##[a-z_A-Z0-9]+##//sg;
    return $tpl;
}
1;

