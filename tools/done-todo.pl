#!/usr/bin/env perl
use warnings;
use strict;

my $file = $ARGV[0] || die "Please supply a file to modify";
my $backup_file = $file . '.bak';

do_replacement( '\* DONE', '* TODO' );
do_replacement( '\[X\]', '[ ]' );
do_replacement( '\[\d+\/(\d+)\]', '[ ]' );

sub do_replacement {
    my ( $regexp, $replacement ) = @_;

    open(my $oldfile, "<", $file)      # open for update
    or die "Can't open $file for reading: $!";

    open(my $newfile, ">", $backup_file)
    or die "Can't open 'install-shilohsystem.org.bak' for writing: $!";

    while (<$oldfile>) {
	if ( ($regexp eq '\[\d+\/(\d+)]') && ( $replacement eq '[0\/$1]')) {
	    s/$regexp/[0\/$1]/;
	} else {
	    s/$regexp/$replacement/;
	}
	print $newfile $_ or die "can't write $newfile: $!";
    }

    close($oldfile)            or die "can't close $oldfile: $!";
    close($newfile)            or die "can't close $newfile: $!";
    rename($backup_file, $file)   or die "can't rename install-shilohsystem.org.bak $file: $!";

}


exit;
__END__

######################################################################
$regexp = ;
$replacement = '[ ]';
open($oldorg, "<", $file)      # open for update
    or die "Can't open $file for reading: $!";
open($neworg, ">", $backup_file)
    or die "Can't open 'install-shilohsystem.org.bak' for writing: $!";
while (<$oldorg>) {
    s/$regexp/$replacement/;
    print $neworg $_ or die "can't write $neworg: $!";
}
close($oldorg)            or die "can't close $oldorg: $!";
close($neworg)            or die "can't close $neworg: $!";
rename($backup_file, $file)   or die "can't rename install-shilohsystem.org.bak $file: $!";

######################################################################
$regexp = '\[\d+\/(\d+)]';
open($oldorg, "<", $file)      # open for update
    or die "Can't open $file for reading: $!";
open($neworg, ">", $backup_file)
    or die "Can't open 'install-shilohsystem.org.bak' for writing: $!";
while (<$oldorg>) {
    $replacement = '[0\/$1]';
#    s/$regexp/[0\/$1]/;
    s/$regexp/$replacement/;
    print $neworg $_ or die "can't write $neworg: $!";
}
close($oldorg)            or die "can't close $oldorg: $!";
close($neworg)            or die "can't close $neworg: $!";
rename($backup_file, $file)   or die "can't rename install-shilohsystem.org.bak $file: $!";

