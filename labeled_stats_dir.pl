#!/usr/bin/perl -w
use strict;

my $supdir = shift;
my @subdirs = `ls $supdir`;
chomp(@subdirs);
foreach my $subdir (@subdirs) {
    next unless $subdir =~ m/^train(\d+)test/;
    my $trainsize = $1;
    my $dir = "$supdir/$subdir";
    my @files = `ls $dir/*/sim`;
    chomp(@files);

    foreach my $file (@files) {
        my $output = $file;
        $output =~ s/sim/labled/g;
        `./print_labeled_stats.pl $file $trainsize > $output`;
    }
}
