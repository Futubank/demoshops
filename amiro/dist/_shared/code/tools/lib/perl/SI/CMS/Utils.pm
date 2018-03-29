
package SI::CMS::Utils;

use Error qw(:try);
use Exceptions;
use SI::DBConnection;
use SI::Utils;
use SI::IniFile;

# siteDBConnection($cfg)
# $cfg is a hashref returned by siteConfig()
#   or path to docroot
sub siteDBConnection {

    my $cfg = shift;

    if(ref($cfg) ne 'HASH') {
        $cfg = siteConfig($cfg);
    }
    return SI::DBConnection::getConnection($cfg->{DB_Host},
        $cfg->{DB_User},$cfg->{DB_Password},$cfg->{DB_Database});
}


sub siteConfig {

    my $docroot = shift;
    my $cfg = $docroot.'_local/config.ini.php';

    my $ret;
    if(-e $cfg) {
        my $ini = SI::IniFile->new($cfg);
        $ret = {
            ROOT_PATH => $docroot,
            ROOT_PATH_WWW => $ini->get('ROOT_PATH_WWW','main'),
            DB_Host => $ini->get('DB_Host','dbaccess'),
            DB_User => $ini->get('DB_User','dbaccess'),
            DB_Password => $ini->get('DB_Password','dbaccess'),
            DB_Database => $ini->get('DB_Database','dbaccess'),
            DB_ConnectionCharset => $ini->get('DB_ConnectionCharset','dbaccess')
        };
        return $ret;
    }
    
    $cfg = $docroot.'_local/config.inc.php';
    if(-e $cfg) {
        $ret = parsePHPFile($cfg);
        $ret->{ROOT_PATH} = $docroot;
        return $ret;
    }
    throw ErrException("Site config not found in ${docroot}_local");
}


# CMS_Core::WriteOption($cModName, $cOptionName, $cValue, $cBigValue=false, $cLang =  "")
# writeCMSOption($dbh,$modName,$optName,$value,$bigValue,$lang);
sub writeCMSOption {
    
    my $dbh = shift;
    my $modName = shift;
    my $optName = shift;
    my $value = shift;
    my $bigValue = shift;
    my $lang = shift;


    my $data = { module_name => $modName,
                    name => $optName,
                    value => $value,
                    date_modified => "|=NOW()"};
    $data->{big_value} = $bigValue if defined $bigValue;
    $data->{lang} = $lang if defined $lang;
    if(readCMSOption($dbh,$modName,$optName,$lang)) {
      my $where .='module_name=? AND name=? ';
      my @vals = ($modName,$optName);
      if(defined $lang) {
          $where .= 'AND lang=?';
          push(@vals,$lang);
      }
      $dbh->updateRecord('cms_options',$data,$where,@vals);
    } else {
        $dbh->insertRecord("cms_options",$data);
    }
    return $data;
}


sub readCMSOption {
    
    my $dbh = shift;
    my $modName = shift;
    my $optName = shift;
    my $lang = shift;

    my @vals = ();
    my $sql = 'SELECT * FROM cms_options WHERE module_name=? AND name=? ';
    push(@vals,$modName,$optName);
    if(defined $lang) {
        $sql .= 'AND lang=?';
        push(@vals,$lang);
    }
    return $dbh->getRecord($sql,1,@vals);
}


sub deleteCMSOption {
    
    my $dbh = shift;
    my $modName = shift;
    my $optName = shift;
    my $lang = shift;

    my $sql = 'DELETE FROM cms_options WHERE module_name=? AND name=? ';
    $sql .= 'AND lang=?' if defined $lang;
    return $dbh->do($sql,$modName,$optName,$lang);
}


sub dbVersion {

    my $dbh = shift;
    my $vo = SI::CMS::Utils::readCMSOption($dbh,'db_version','cms');
    return $vo->{value};
}


sub _setPerm {

    my ($docroot,$dp,$fp,$dirs,$files) = @_;

    foreach my $dir (@$dirs) {
        -d "$docroot/$dir" && chmodRecursive($dp,$fp,"$docroot/$dir");
    }
    foreach my $file (@$files) {
        chmod($fp,"$docroot/$file");
    }
}

sub setFilePermissions {

    my $docroot = shift;
    my $mode = shift;
    my $setgid = shift;
    $setgid = 1 if !defined $setgid;

    # TODO: take these lists from config
    my @roDirs = ('_admin','_css','_img','_js','_local',
        '_shared','aff_icons','ftpicons','treeimgs','_wizard','includes','_designs');
    my @roFiles = ('cm_ini.php','eshop_final.php','ftpgetfile.php','index.php',
        'pages.php','show_numimage.php','show_pic.php','aproc.php','calendar.php','system_js.php');
    my @rwDirs = ('_mod_files','_shared/sys','templates','_local/_admin/templates');
    my @rwFiles = ('_admin/_logs/err.log');

    if($mode eq 'update') {
        SI::CMS::Utils::_setPerm($docroot,0777,0666,\@roDirs,\@roFiles);
        SI::CMS::Utils::_setPerm($docroot,0777,0666,\@rwDirs,\@rwFiles);
    } elsif($mode eq 'runtime') {
        SI::CMS::Utils::_setPerm($docroot,0755,0644,\@roDirs,\@roFiles);
        # 02777: setgid dirs so that group quotas do work on Linux
        my $dirmode = $setgid ? 02777 : 0777;
        SI::CMS::Utils::_setPerm($docroot,$dirmode,0666,\@rwDirs,\@rwFiles);
    } else {
        throw ErrException("Unknown CMS file permissions mode '$mode'");
    }
}

sub setFileOwner {

    my ($docroot,$uid,$gid) = @_;
    chownDir($docroot,$uid,$gid);
}


sub setHomedirPermissions {

    my $dir = shift;
    my $httpdGroup = shift;

    if($httpdGroup !~ /^\d+$/) {    
	my @g = getgrnam($httpdGroup);
	throw ErrException("Nonexistent webserver group '$httpdGroup'") if(!defined $g[2]);
	$httpdGroup = int($g[2]);
    }
    throw ErrException("Will not chgrp 0 home directory") if $httpdGroup==0;
    chown(-1,$httpdGroup,$dir) || throw ErrException("chgrp 0 $dir failed");
    chmod(0710,$dir) || throw ErrException("chmod 0710 $dir failed");
}


# delete all records related to one site from cluster db
# TODO: move somewhere to cluster module
sub deleteSiteRecords {


    my($dbh,$uId,$mId) = (shift,shift,shift);
    
    $dbh->do('DELETE FROM cms_members WHERE id=?',$mId);
    $dbh->do('DELETE FROM cms_subs_members WHERE id_member=?',$mId);
    $dbh->do('DELETE FROM cms_host_traffic WHERE id_user=?',$uId);
    $dbh->do('DELETE FROM cms_host_user_emails WHERE user_id=?',$uId);
    $dbh->do('DELETE FROM cms_host_payments WHERE id_user=?',$uId);
    $dbh->do('DELETE FROM cms_host_payments_history WHERE id_user=?',$uId);
    $dbh->do('DELETE FROM cms_host_login_history WHERE id_member=?',$mId);
    $dbh->do('DELETE FROM cms_host_users WHERE id=?',$uId);
}
				    

###################################################################################
package SI::CMS::SiteLock;

use Error qw(:try);
use Exceptions;
use SI::Template;
use SI::Utils;

sub new {

    my $class = shift;
    my $self = {};
    $self->{tplFile} = shift;
    $self->{locksPath} = shift;
    $self->{data} = shift;
    $self->{data} = {} if !defined $self->{data};
    
    bless $self,$class;
}

# front|admin|status,docroot|pcfg
sub _vars {

    my $self = shift;
    my ($type,$scfg) = @_;

    my $status = 0;
    if($type =~ /^status/) {
        $status = 1;
    };

    if(ref($scfg) ne 'HASH') {
        # docroot
        my $docroot = $scfg;
        if($docroot ne $self->{lastDocroot}) {
            # cache parsed site config
            $scfg = SI::CMS::Utils::siteConfig($docroot);
            $self->{lastDocroot} = $docroot;
            $self->{lastCfg} = $scfg;
        } else {
            $scfg = $self->{lastCfg};
        }
    } else {
        $self->{lastCfg} = $scfg;
        $self->{lastDocroot} = $scfg->{ROOT_PATH};
    }

    my $dest = defined $self->{locksPath} && !$status ? $self->{locksPath} : $scfg->{ROOT_PATH}.'_shared/sys/var/locks/';
    my $id = siteIdString($scfg->{ROOT_PATH_WWW});
    $dest .= $status ? 'status' : "$id.$type";

    return ($type,$status,$dest,$id);
}


sub _write {

    my $self = shift;
    my $dest = shift;
    my $set = shift;
    my $data = shift;
    $data = $self->{data} if !defined $data;

    my $tpl = SI::Template->new();
    $tpl->addBlock('lock',$self->{tplFile});
    my $content = $tpl->get("lock:lock_$set",$data);
    my $res = $dest;
    try {
        writeFile($tpl->get("lock:page",{content=>$content}),$dest);
    } catch ErrException with {
        $res = undef;
    };

    return $res;
}


# front|admin|status,docroot|pcfg,set,data
sub put {

    my $self = shift;
    my ($type,$status,$dest,$id) = $self->_vars(shift,shift);
    my ($set,$data) = @_;
    $data = $self->{data} if !defined $data;

    my $res = $self->_write($dest,$set,$data);
    $status && chmod(0666,$dest); # so that PHP can delete it

    return ($res,$id);
}

sub putGlobal {

    my $self = shift;
    my $type = shift;
    my $set = shift;
    my $data = shift;

    return $self->_write($self->{locksPath}.$type,$set,$data);

}

# front|admin|status,docroot|pcfg
# or lockfile as single argument
sub remove {

    my $self = shift;
    my $dest;
    if(scalar(@_)==1) {
        $dest = shift;
    } else {
        (undef,undef,$dest,undef) = $self->_vars(shift,shift);
    }
    return (unlink($dest),$dest);
}

sub removeGlobal {

    my $self = shift;
    my $type = shift;

    return unlink($self->{locksPath}.$type);

}

1;
