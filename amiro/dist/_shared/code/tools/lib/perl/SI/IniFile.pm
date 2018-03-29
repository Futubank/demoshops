
package SI::IniFile;

use Error qw(:try);
use Exceptions;
use SI::Utils;



sub new {

    my $class = shift;
    my $self = {data=>{}};
    bless $self,$class;
    my $file = shift;
    $self->readFile($file) if defined $file;
    return $self;
}


sub readFile {

    my $self = shift;
    my $file = shift;

    my $fd = SI::Utils::openFile($file);
    my $sect;
    my $linenum = 0;
    try {
        while(<$fd>) {
            $linenum++;
            s/\r?\n//;
            next if /^\s*;/ || /^\s*$/;
            if(/^\[(\w+)\]\s*$/) {
                $sect = $1;
                next;
            }
            if(/^(\S+)\s*=\s*("?)([^"]*)\2\s*$/) {
                throw ErrException("No section defined in INI file $file, line $linenum") if !defined $sect;
                my $val = $3;
                $val = '' if $val eq 'false' || $val eq 'no' || $val eq 'null';
                $val = 1 if $val eq 'yes' || $val eq 'true';
                my $key = $1;
                $val =~ s/\s+$// if $2 eq '';
                $self->{data}->{$sect}->{$key} = $val;
                next;
            }
            throw ErrException("Syntax error in INI file $file, line $linenum");
        }
    } finally {
        close($fd);
    };
}

sub writeFile {

    my $self = shift;
    my $file = shift;
    my $phpStop = shift;
    $phpStop = 1 if !defined $phpStop;

    my $fd = SI::Utils::openFile($file,'>');
    try {
        if($phpStop) {
            print $fd "\n;<?php /* !!! DO NOT REMOVE THIS LINE !!! */ die(); ?>\n";
        }
        print $fd "\n";
        foreach my $sect (keys %{$self->{data}}) {
            print $fd "[$sect]\n\n";
            foreach my $key (keys %{$self->{data}->{$sect}}) {
                my $value = $self->{data}->{$sect}->{$key};
                $value =~ s/"/'/g; #' parse_ini_file() cannot handle "
                $value = "\"$value\"" if $value !~ /^(yes|no|null|true|false|\d+)$/i;
                print $fd "$key\t=\t$value\n";
            }
            print $fd "\n\n";
        }
    } finally {
        close($fd);
    };
}


sub get {
    my $self = shift;
    my $key = shift;
    my $sect = shift;
    return $self->{data}->{$sect}->{$key};
}

sub set {
    my $self = shift;
    my $key = shift;
    my $sect = shift;
    my $value = shift;

    if(defined $value) {
        $self->{data}->{$sect}->{$key} = $value;
    } else {
        delete $self->{data}->{$sect}->{$key};
    }
}

1;
