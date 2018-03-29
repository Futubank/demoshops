#!/usr/bin/perl

package SI::Utils;

use Error qw(:try);
use Exceptions;
use Data::Dumper;
use Fcntl qw(:flock);

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(openFile readFile writeFile catFile revDomain splitDomain removeLines replaceInFile 
            createPassword splitPath verifyEmailAddress 
            escapeShell parsePHPFile writeHashToFile readHashFromFile
            parseCommandLine findProg runCmd formatDate sendMail rmDir siteIdString 
            chmodRecursive chownRecursive parseUrl chownDir findAnotherInstance lockPidFile
            timeInterval
            SI_CMD_THROW SI_CMD_REDIR
            );

sub SI_CMD_THROW        { 1; }
sub SI_CMD_NOREDIR      { 2; }

sub openFile {
	my $fname = shift;
	my $op = shift;
	my $ff;

	!defined $op && {$op = ''};
	open($ff,"$op$fname") || throw ErrException("Cannot open '$fname','$op'");
	return $ff;
}

#TODO: make *File() functions binary-safe

sub readFile {
	my $fname = shift;
    my $asString = shift;
    $asString = 1 if !defined $asString;
    my $fd = openFile($fname);
    my @adata = <$fd>;
    close($fd);
    if($asString) {
        return join('',@adata);
    } else {
        return @adata;
    }
}


sub writeFile {
    my $txt = shift;
	my $fname = shift;
    my $mode = shift;
    my $text;

    if(ref($txt) eq '') {
        $text = \$txt;
    } else {
        $text = $txt;
    }
    $mode = '>' if !defined $mode;
    my $fd = openFile($fname,$mode);
    print $fd $$text;
    close($fd);
}


sub catFile {

    my $src = shift;
    my $dst = shift;
    my $mode = shift;
    $mode = '>>' if !defined $mode;

    my $in = openFile($src);
    my $out = openFile($dst,$mode);
    while(<$in>) {
        print $out $_;
    }
    close($out);
    close($in);
}


sub revDomain {

    my $domain = shift;
    my $rd = '';
    while($domain =~ /(\S+)\.(\S+)/) {
	$rd .= "$2.";
	$domain = $1;
    }
    return $rd.$domain;
}

sub splitDomain {

    my $domain = shift;
    $domain =~ /^(\S+)\.([^\.]+\.[^\.]+)$/ &&  return ($1,$2);
    $domain =~/^([^\.]+\.[^\.]+)$/ && return ('',$1);
    return ('','');
}

sub splitPath {

    my $fullPath = shift;
    my @parts = split(/\//,$fullPath);
    my $file = pop(@parts);

    return (join('/',@parts),$file);
}

sub removeLines {

    my $file = shift;
    my $re = shift;

    my @adata = readFile($file,0);
    my $fd = openFile($file,'>');
    foreach (@adata) {
    	next if $_ =~ $re;
	    print $fd $_;
    }
    close($fd);
    return 1;
}


# replaceInFile($filename,(qr/.../=>$str1,qr/.../=>$str2, ...))
sub replaceInFile {

    my $file = shift;
    my %rep = @_;
    my $re;

    my $text = readFile($file);
    foreach $re (keys(%rep)) {
	    $text =~ s/$re/$rep{$re}/gs;
    }
    writeFile($text,$file);    
    return 1;
}


sub createPassword {

    my ($len) = @_;
    my $rnd;
    my $password = '';
    my $ch;

    if(!defined $len || $len < 5) {
        $len = 5;
    }

    for ($i = 0; $i < $len; $i++) {
        $rnd = rand(5);
        if($rnd < 2) {
            $ch = chr(ord('a') + int(rand(25)));
        } elsif ($rnd < 4) {
            $ch = chr(ord('A') + int(rand(25)));
        } else {
            $ch = chr(ord('0') + int(rand(10)));
        }
        $password .= $ch;
    }

    return $password;
}


sub verifyEmailAddress {

    my $email = shift;

    my ($local,$domain) = split(/@/,$email);
    return () if !$local || !$domain;
    $local = lc($local);
    $domain = lc($domain);
    # TODO: more checks
    $local =~ /[^a-z0-9\.\-_]/ && return ();
    $domain =~ /[^a-z0-9\.\-]/ && return ();
    return ($local,$domain);
}



sub writeHashToFile {

    my $hash = shift;
    my $file = shift;
    my $mode = shift;

    local $Data::Dumper::Indent = 0;
    writeFile(Dumper($hash),$file,$mode);
}

sub readHashFromFile {

    my $file = shift;
    my $text = readFile($file);
    my $VAR1;
    eval $text;
    @? and throw ErrException("HASH from file '$file': @?");

    return $VAR1;
}





sub parseCommandLine {

    my @cline = @_;
    my %options = ();
    my @params = ();

    my $len = scalar @cline;
    for(my $i=0; $i<$len; $i++) {
        if($cline[$i] =~ /^-(.*)$/) {
            my $opt = $1;
            if($i+1<$len) {
                if($cline[$i+1] =~ /^-(.*)$/) {
                    # -o1 -o2
                    $options{$opt} = undef;
                } else {
                    # -o1 val
                    $options{$opt} = $cline[++$i];
                }
            } else {
                # last option
                $options{$opt} = undef
            }
        } else {
            # argument
            push(@params,$cline[$i]);
        }
    }
    return (\%options,@params);
}

sub runCmd {

    my $cmd = shift;
    my $flags = shift;
    $flags = SI_CMD_THROW if !defined $flags;

    my @args = @_;
    foreach my $arg (@args) {
        $arg =~ s/([\$\\\"])/\\$1/g;
        $arg  = "\"$arg\"";
    }
    $cmd = "$cmd @args";

    $cmd = "$cmd 2>&1" if !($flags & SI_CMD_NOREDIR);
    my @r = ();
    if($flags & SI_CMD_NOREDIR) {
        system($cmd);
    } else {
        @r = `$cmd`;
    }
    if($? && ($flags & SI_CMD_THROW)) {
        throw ErrException("runCommand($cmd): @r",$?);
    }
    return @r;
}

sub findProg {

    my $bin = shift;
    my @paths = ('/bin','/usr/bin','/usr/local/bin');
    scalar @_ && push(@paths,@_);
    foreach(@paths) {
        my $prg = "$_/$bin";
        -x $prg && return $prg;
    }
    return undef;
}


sub recurseDir {

    my $dir = shift;
    my $hdl = shift;
    my $dots = shift;
    $dots = 0 if !defined $dots;
    my @hdlData = @_;

    my $dh;
    opendir($dh,$dir) || throw ErrException("Cannot open directory $dir");
    my @sub = readdir($dh);
    closedir($dh);
    $ret = 1;
    foreach my $f (@sub) {
        next if(($f eq '.' || $f eq '..') && !$dots);
        my $full = "$dir/$f";
        next if -d $full && -l $full;
        -d $full && recurseDir($full,$hdl,$dots,@hdlData);
        if(ref($hdl) eq 'CODE') {
            $ret = $ret && &$hdl($full,@hdlData);
        } else {
            # suppose $hdl is an object
            $ret = $ret && $hdl->processFile($full);
        }
    }
    return $ret;
}

sub copyDirs {

    my $dst = shift;
    my $subDirsOnly = shift;
    $subDirsOnly = 1 if !defined $subDirsOnly;

    my @src = ();
    foreach my $dir(@_) {
        $dir = escapeShell($dir);
        if($subDirsOnly) {
            $dir .= '/*';
        }
        push(@src,$dir);
    }
    runCommand("$cpCmd @src",1,$dst);
}

sub formatDate {

    my ($format,$time) = @_;
    $time = time() if !defined $time;
    $format = "DD.MM.YYYY hh:mm:ss" if !defined $format;

    my $date = $format;
    my ($sec, $min, $hour, $mday, $mon, $year) = localtime($time);

    $date =~ s/MM/%02d/g;
    $date = sprintf($date, $mon + 1);

    $date =~ s/DD/%02d/g;
    $date = sprintf($date, $mday);

    $date =~ s/YYYY/%d/g;
    $date = sprintf($date, $year + 1900);

    $date =~ s/hh/%02d/g;
    $date = sprintf($date, $hour);

    $date =~ s/mm/%02d/g;
    $date = sprintf($date, $min);

    $date =~ s/ss/%02d/g;
    $date = sprintf($date, $sec);

    return $date;
}


# sendMail(to,subj,body,hdr,driver)
# driver: 'prog:sendmail' (try to find with findProg()) 
#    or 'prog:/usr/sbin/sendmail'
#    or 'smtp:host.com:port'
sub sendMail {

    my ($to,$subj,$body,$hdr,$drv) = @_;
    $drv = 'prog:sendmail' if !defined $drv;
    my @d = split(/:/,$drv);

    my $sm = undef;
    if($d[0] eq 'prog') {
        if($d[1] =~ /^\//) {
            !-x $d[1] && throw ErrException("SI::Utils::sendMail: '$d[1]' is not an executable");
            $sm = $d[1];
        } else {
            $sm = findProg($d[1],'/usr/sbin','/usr/libexec');
            !defined $sm && throw ErrException("SI::Utils::sendMail: '$d[1]' not found");
        }

        my $msg = '';
        foreach(keys %$hdr) {
            $msg .= "$_: $$hdr{$_}\r\n";
        }
        $msg .= "To: $to\r\n";
        $msg .= "Subject: $subj\r\n";
        $msg .= "\r\n$body";

        $smh = openFile("$sm -t",'|');
        print $smh $msg;
        close($smh);

    } else {
        throw ErrException("SI::Utils::sendMail: driver '$d[0]' not implemented");
    }
}


sub rmDir {

    my $dir = shift;
    my $dirToo = shift;
    $dirToo = 1 if !defined $dirToo;
    my $force = shift;
    $force = 0 if !defined $force;

    $force && !-e $dir && return 1;
    my $res = SI::Utils::recurseDir($dir,
        sub {
            my $fname = shift;
            -d $fname && return rmdir($fname);
            -f $fname && return unlink($fname);
        },0);
    $res = $res && rmdir($dir) if $dirToo;
    !$res && throw ErrException("SI::Utils::rmDir(): $dir: not all files deleted");
    return $res;
}

sub siteIdString {

    my $wwwPath = shift;
    $wwwPath =~ s!^http[s]?://!!;
    $wwwPath =~ s!/!_!g;
    $wwwPath =~ s!_$!!g;
    return $wwwPath;
}


sub chmodRecursive {

    my ($dirMod,$fileMod,@dirs) = @_;

    $res = 1;
    foreach my $dir (@dirs) {
        $res = $res &&  SI::Utils::recurseDir($dir,
            sub {
                my ($fname,$dm,$fm) = @_;
                -d $fname && return defined $dm ? chmod($dm,$fname) : 1;
                -f $fname && return defined $fm ? chmod($fm,$fname) : 1;
            },
            0,$dirMod,$fileMod) && (defined $dirMod ? chmod($dirMod,$dir) : 1);
    }
}

# uid, gid: name, int, undef
sub chownRecursive {

    my ($iuid,$igid,@dirs) = @_;

    my ($uid,$gid);
    if($iuid =~ /\D/) {
        $uid = getpwnam($iuid);
        !defined $uid && throw ErrException("Unix user '$iuid' does not exist");
    } else {
        $uid = $iuid;
    }
    if($igid =~ /\D/) {
        $gid = getgrnam($igid);
        !defined $gid && throw ErrException("Unix group '$igid' does not exist");
    } else {
        $gid = $igid;
    }

    $res = 1;
    foreach my $dir (@dirs) {
        $res = $res &&  SI::Utils::recurseDir($dir,
            sub {
                my ($fname,$uid,$gid) = @_;
                $uid = -1 if !defined $uid;
                $gid = -1 if !defined $gid;
                return chown($uid,$gid,$fname);
            },
            0,$uid,$gid) && chown(defined $uid ? $uid : -1,defined $gid ? $gid : -1,$dir);
    }
    return $res;
}

# [ug]id:
#   name    - getpw*()
#   num
#   -1      - leave intact
#   undef   - stat $dir and get from there
sub chownDir {

    my ($dir,$uid,$gid) = @_;

    if(!defined $uid || !defined $gid) {
        my @s = stat($dir);
        @s || throw ErrException("Cannot stat '$dir'");
        $uid = $s[4] if !defined $uid;
        $gid = $s[5] if !defined $gid;
    }
    chownRecursive($uid,$gid,$dir);
}



sub parseUrl {

    my $url = shift;
    my %res = ();

    if($url =~ /^([^\/]+\/\/)?(.*)/) {
        $res{proto} = $1 if "$1" ne '';
        $url = $2;
    }
    if($url =~ /^([^:]+):(.*)/) {
        $res{host} = $1;
        $url = $2;
        if($url =~ /^(\d+)(.*)/) {
            $res{port} = $1;
            $res{uri} = $2;
        } else {
            return undef;
        }
    } elsif($url =~ /^([^\/]+)(.*)/) {
        $res{host} = $1;
        $res{uri} = $2;
    } else {
        return undef;
    }
    return \%res;
}


sub escapeShell {

    my @args = ();
    foreach my $arg (@_) {
        $arg =~ s/([\~\`\!\@\#\$\%\^\&\*\(\)\\\|\{\}\[\]\;\'\"\<\>])/\\$1/g;
        push(@args,$arg);
    }
    return scalar(@args)>1 ? @args : $args[0];
}

sub parsePHPFile {

    my $file = shift;
    my $withType = shift;
    $withType = 0 if !defined $withType;
    my $res = {};

    my @lines = readFile($file,0);
    foreach my $line (@lines) {
        $line =~ /^\s*(#|\/\/)/ && next;
        if($line =~ /\$([\w\d]+)\s*=\s*(['"])([^\2]+)\2\s*;/) {     #'
            # assignment
            if($withType) {
                $res->{$1}->{value} = $3;
                $res->{$1}->{type} = 'var';
            } else {
                $res->{$1} = $3;
            }
            next;
        }
        if($line =~ /define\s*\(\s*(['"])([^\1]+)\1\s*,\s*(["']?)([^\3]+)\3\s*\)\s*;/) {
            # define
            if($withType) {
                $res->{$2}->{value} = $4;
                $res->{$2}->{type} = 'define';
            } else {
                $res->{$2} = $4;
            }
            next;
        }
    }
    return $res;
}

# findAnotherInstance($pidFile,\$pidFD)
# $pidFD==undef: close PID file after check
# Returns 
#   0 if pidfile flocked successfully
#   pid from pidfile (or -1 if no pid written) if flock fails
sub findAnotherInstance {

    my $pidFile = shift;
    my $pidFD = shift;

    my $fd = openFile($pidFile,'+>>');

    my $notRunning = flock($fd,LOCK_EX|LOCK_NB);
    seek($fd,0,0);
    my $pid = <$fd>;
    $pid = -1 if !$pid;
    if(!defined $pidFD) {
        close($fd);
    } else {
        seek($fd,0,0);
        $$pidFD = $fd;
    }
    return $notRunning ? 0: $pid;
}

sub lockPidFile {

    my $pidFile = shift;
    my $pidFD = 0;

    my $pid = findAnotherInstance($pidFile,\$pidFD);
    $pid && throw ErrException("Another instance is running, pid=$pid",$pid);
    truncate($pidFD,0);
    my $oldFD = select($pidFD);
    $| = 1;
    print $pidFD $$;
    select($oldFD);
 
    return $pidFD;
}

# Returns number of seconds (rough)
# Format: [\-+]?\d+[mhdwny].*
sub timeInterval {

    my $dts = shift;

    throw ErrException("Invalid time interval '$dts'") if !defined $dts || $dts !~ /^([\-+]?)(\d+)([mhdwny])/;
    my $sign = $1 eq '' || $1 eq '+' ? 1 : -1;
    my $num = $2;
    my $unit = $3;
    if($unit eq 'm') {
        $num *= 60;
    } elsif($unit eq 'h') {
        $num *= 3600;
    } elsif($unit eq 'd') {
        $num *= 3600*24;
    } elsif($unit eq 'w') {
        $num *= 3600*24*7;
    } elsif($unit eq 'n') {
        # suppose there are always 30 days in a month
        $num *= 3600*24*30;
    } elsif($unit eq 'y') {
        # suppose there are always 365 days in a year
        $num *= 3600*24*365;
    }

    return $num*$sign;
}


1;
