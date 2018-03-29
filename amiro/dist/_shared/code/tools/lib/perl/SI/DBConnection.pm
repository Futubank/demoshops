#!/usr/bin/perl

package SI::DBStatement;

use Error qw(:try);
use Exceptions;
#use SI::Utils;

sub new {

    my $class = shift;
	my $self = {};
    
    $self->{_dbh} = shift;
    $self->{_sth} = shift;
    bless $self,$class;
}


sub execute {

    my $self = shift;
    my $ret;
    eval { $ret = $self->{_sth}->execute(@_) };
    if($@) { throw DBException($@,$self->{_dbh}->err); }
    return $ret;
}

sub fetchrow_array {

    my $self = shift;
    my @ret;
    eval { @ret = $self->{_sth}->fetchrow_array(@_) };
    if($@) { throw DBException($@,$self->{_dbh}->err); }
    return @ret;
}

sub fetchrow_hashref {

    my $self = shift;
    my $ret;
    eval { $ret = $self->{_sth}->fetchrow_hashref(@_) };
    if($@) { throw DBException($@,$self->{_dbh}->err); }
    return $ret;
}

sub finish {

    my $self = shift;
    my $ret;
    eval { $ret = $self->{_sth}->finish(@_) };
    if($@) { throw DBException($@,$self->{_dbh}->err); }
    return $ret;

}

########################################################################################

package SI::DBConnection;

use Error qw(:try);
use Exceptions;
use DBI;
use SI::Utils;
use Data::Dumper;

sub new {

    my $class = shift;
	my $self = {};
    my ($host,$port) = @_;
    $host = 'localhost' if !defined $host;
    $port = int($port);
    $port = 3306 if $port==0;
    if ($host ne 'localhost' && $port!=3306) {
        $port = ";port=3306";
    } else {
        $port = '';
    }
    
    $self->{_ds} = "dbi:mysql:host=$host$port";
    $self->{_dbName} = $db;
    bless $self,$class;
}


sub connect {

    my $self = shift;
    my $dbh;
    eval { $dbh = DBI->connect($self->{_ds},shift,shift,
                        {RaiseError=>1,ShowErrorStatement=>1,PrintError=>0}) };
    if($@) { throw DBException("Cannot connect to $self->{_ds}: ".$DBI::errstr,-1); }
    $dbh->{mysql_auto_reconnect} = 1;
    $self->{_dbh} = $dbh;
    return $dbh;
}

sub disconnect {

    my $self = shift;
    eval { $self->{_dbh}->disconnect(); };
    if($@) { throw DBException("Disconnect: ".$DBI::errstr,-1); }
}

# static getConnection($host,$user,$password,$db,$port)
sub getConnection {

    my ($host,$user,$password,$db,$port) = @_;
    my $dbh = SI::DBConnection->new($host,$port);
    $dbh->connect($user,$password);
    defined $db && $dbh->useDB($db);
    return $dbh;
}


sub prepare {

    my $self = shift;
    my $sth;
    eval { $sth = $self->{_dbh}->prepare(@_) };
    if($@) { throw DBException($@,$self->{_dbh}->err); }
    $self->{_sth} = SI::DBStatement->new($self->{_dbh},$sth);
    return $self->{_sth};
}


#sub _do {

#    my $self = shift;
#    my $ret;
#    eval { $ret = $self->{_dbh}->do(@_) };
#    if($@) { throw DBException($@,$self->{_dbh}->err); }
#    return $ret;
#}

sub useDB {
    
    my $self = shift;
    my $db = shift;
    $self->do("USE `$db`");
    $self->{_dbName} = $db;
}


sub curDBName { my $self = shift; return $self->{_dbName}; }


sub pushDB {

    my $self = shift;
    my $dbname = shift;

    $self->{dbNameStack} = [] if !defined $self->{dbNameStack};
    push(@{$self->{dbNameStack}},$self->curDBName);
    try {
        $self->useDB($dbname);
    } catch ErrException with {
        my $e = shift;
        $self->popDB();
        throw $e;
    };
}


sub popDB {

    my $self = shift;
    my $dbname = pop(@{$self->{dbNameStack}});
    $self->useDB($dbname) if defined $dbname;
    return $dbname;
}

sub do {

    my $self = shift;
    my $sql = shift;

    my $sth = $self->prepare($sql);
    my $ret = $sth->execute(@_);
    return $ret;
}



sub select {

    my $self = shift;
    my $sql = shift;

    my $sth = $self->prepare($sql);
    $sth->execute(@_);
    return $sth;
}


sub getRecord {

    my $self = shift;
    my $sql = shift;
    my $type = shift;
    $type = 1 if !defined $type;    # 0 - array, 1 - hashref

    my $sth = $self->prepare($sql);
    $sth->execute(@_);
    if($type) {
        my $hr = $sth->fetchrow_hashref();
        $sth->finish();
        return $hr;
    } else {
        my @hr = $sth->fetchrow_array();
        $sth->finish();
        return @hr;
    }

    return $hr;
}


sub getRecordsByKey {

    my $self = shift;
    my $table = shift;
    my $value = shift;
    my $key = shift;
    $key = 'id' if !defined $key;

    my $sth = $self->select("SELECT * FROM $table WHERE $key=?",$value);
    my @rec = ();
    while($pr = $sth->fetchrow_hashref()) {
        push(@rec,$pr);
    }
    $sth->finish();
    return @rec;
}


sub getUnique {

    my $self = shift;
    my ($table,$value,$field) = @_;
    my $type = shift;

    $field = 'id' if !defined $field;
    my $sql = "SELECT * FROM $table WHERE $field=?";
    return $self->getRecord($sql,$type,$value);
}

sub getLastInsertId {

    my $self = shift;
    my ($id) = $self->getRecord("SELECT LAST_INSERT_ID()",0);
    return $id;
}


sub insertRecord {

    my $self = shift;
    my ($table,$rec) = @_;

    my ($sql,@v) = makeInsertSql($table,$rec);
    my $sth = $self->prepare($sql);
    $sth->execute(@v);
}

sub updateRecord {

    my $self = shift;
    my ($table,$rec,$cond) = (shift,shift,shift);

    my ($sql,@v) = makeUpdateSql($table,$rec);
    my $sth = $self->prepare("$sql WHERE $cond");
    $sth->execute(@v,@_);
}


#########################################################################
#
# static utilities
#

sub makeInsertSql {

    my ($tbl,$rec) = @_;
    my $sql = "INSERT $tbl (";
    my $fields = '';
    my $values = '';
    
    my @f = keys(%$rec);
    my @v = ();
    foreach(@f) {
	    $fields .= "$_,";
        if(substr($$rec{$_},0,2) eq '|=') {
	        $values .= substr($$rec{$_},2).",";
        } else {
            $values .= '?,';
            push(@v,$$rec{$_});
        }
    }

    $fields =~ s/,$//;
    $values =~ s/,$//;
    
    $sql .= "$fields) VALUES ($values)";
    
    return ($sql,@v);
}

sub makeUpdateSql {

    my ($tbl,$rec) = @_;
    my $sql = "UPDATE $tbl SET ";
    my $fields = '';
    my $values = '';
    
    my @f = keys(%$rec);
    my @v = ();
    foreach(@f) {
	    $fields .= "$_=";
        if(substr($$rec{$_},0,2) eq '|=') {
	        $fields .= substr($$rec{$_},2).",";
        } else {
            $fields .= '?,';
            push(@v,$$rec{$_});
        }
    }

    $fields =~ s/,$//;
    $sql .= $fields;
    return ($sql,@v);
}


1;
