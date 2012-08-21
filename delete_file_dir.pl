#!/usr/bin/perl -w
use strict;

my $supdir = shift;
my @subdirs = `ls $supdir`;
chomp(@subdirs);

foreach my $d (@subdirs) {
    next unless $d =~ m/train\d+test/;
    my $dir = $supdir.'/'.$d;

    my @files_to_delete = `ls $dir/*/dot`;
    chomp (@files_to_delete);

    `rm $_` foreach (@files_to_delete);
}

