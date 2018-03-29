
package SI::Tar;

use Error qw(:try);
use Exceptions;
use Cwd;
use SI::Utils;

use constant ZLIB           => do { eval { require IO::Zlib }; $@ ? 0 : 1 };
use constant TARMODULE      => do { eval { require Archive::Tar }; $@ ? 0 : 1 };

use constant TAR_ERR_CHMOD  => 0x01;
use constant TAR_ERR_UTIME  => 0x02;
use constant TAR_ERR_ALL    => 0xff;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(TAR_ERR_CHMOD TAR_ERR_UTIME); 

sub new {

    my $class = shift;
    my $file = shift;                   # tar file name
    my $tarProg = shift;                # /path/to/tar
    my $gz = shift;
    $gz = $file =~ /gz$/i ? 1 : 0 if !defined $gz;

    $tarProg = findProg('tar') if !defined $tarProg;


    $gz && !defined $tarProg && !ZLIB && throw ErrException("ERR_NO_GZ Cannot handle gzipped archives on this machine");
    !defined $tarProg && !TARMODULE && 
        throw ErrException("ERR_NO_TAR Archive::Tar is not installed, and tar program not found");

    if(defined $tarProg && !-x $tarProg) {
        throw ErrException("ERR_INVALID_TARPROG tar program '$tarProg' is not executable");
    }

    my $self = {};
    my $pstart = $^O eq 'MSWin32' ? qr/^[a-zA-Z]:/ : qr/^\//;
    if($file !~ /$pstart/) {
        my $wd = cwd();
        $file = "$wd/$file";
    }
    $self->{file} = $file;
    $self->{tarProg} = $tarProg;
    $self->{gz} = $gz;
    $self->{warns} = [];
    
    $Archive::Tar::WARN = 0;

    bless $self,$class;
}


# createArchive($baseDir,\@incl,\@excl)
sub createArchive {

    my $self = shift;
    my $baseDir = shift;
    my $r = shift;
    my @incl = @$r;
    my $r = shift;
    my @excl = @$r;

    if(defined $self->{tarProg}) {
        my $gz = $self->{gz} ? 'z' : '';
        my $tarCmd = $self->{tarProg}." -cp${gz}f ".$self->{file}." -C $baseDir ";
        foreach my $f (@excl) {
            $tarCmd .= " --exclude $f ";
        }
        my @r = runCmd($tarCmd,0,@incl);
        $? && throw ErrException("ERR_TARPROG_ERROR $tarCmd @incl returned error: @r");
    } else {
        my $wd = cwd();
        chdir($baseDir) || throw ErrException("ERR_CHDIR Cannot chdir to $baseDir");
        try {
            my @files = ();
            foreach my $f (@incl) {
                my $ex = 0;
                foreach my $e (@excl) {
                    if($f eq $e || $f =~ /^\Q$e\E\//) {
                        $ex = 1;
                        last;
                    }
                }
                next if $ex;
                if(-d $f && !-l $f) {
                    opendir(DIR,$f) ||
                        throw ErrException ("ERR_TAR_PERM Cannot read directory $baseDir/$f");
                    my @sub = grep { $_ ne '.' && $_ ne '..' } readdir(DIR);
                    closedir(DIR);
                    foreach my $ff (@sub) {
                        push(@incl,"$f/$ff");
                    }
                }
                push(@files,$f);
            }
            eval { Archive::Tar->create_archive($self->{file},$self->{gz},@files); };
            Archive::Tar->error &&
                throw ErrException("ERR_TAR_CREATE Cannot create $self->{file}: ".Archive::Tar->error);
        } finally {
            chdir($wd);
        }
    }
}


sub warnings {

    my $self = shift;
    my $reset = shift;

    $self->{warns} = [] if defined $reset;
    return @{$self->{warns}};
}


# extractArchive($baseDir,$errMask)
# $errMask: what errors to ignore
sub extractArchive {

    my $self = shift;
    my $baseDir = shift;
    my $errMask = shift;
    $errMask = 0 if !defined $errMask;

    $self->warnings(1);
    if(defined $self->{tarProg}) {
        my $gz = $self->{gz} ? 'z' : '';
        my $tarCmd = $self->{tarProg}." xp${gz}f ".$self->{file}." -C $baseDir";
        my @r = runCmd($tarCmd,0,@files);
        if($?) {
            $self->{warns} = \@r;
            my $err = _extractErrors(@r);
            throw ErrException("ERR_TARPROG_ERROR $tarCmd returned error ($?): @r") if $err & ~$errMask;
        }
    } else {
        my $wd = cwd();
        chdir($baseDir) || throw ErrException("ERR_CHDIR Cannot chdir to $baseDir");
        try {
            Archive::Tar->extract_archive($self->{file},$self->{gz}) ||
                throw ErrException("ERR_TAR_CREATE Cannot extract from $self->{file}: ".Archive::Tar->error);
        } finally {
            chdir($wd);
        }
    }
}

sub _extractErrors {

    my @r = @_;
    my $err = 0;

    if($^O eq 'MSWin32') {
        foreach(@r) {
            next if /Skipping/i;
            $err |= TAR_ERR_CHMOD if /set\s+permissions:\s+Function\s+not\s+implemented/i; 
        }
    } else {
        foreach(@r) {
            # assume GNU tar
            next if /exit\s+delayed/i;
            $err |= TAR_ERR_CHMOD if /Cannot\s+change\s+mode/i; 
            $err |= TAR_ERR_UTIME if /Cannot\s+utime/i; 
        }
    }
    return $err;
}

1;
