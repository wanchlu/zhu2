#! /usr/bin/perl -w
use strict;
my $cnt = 0;
while(<>) {
    chomp;
    my @tokens = split /\s+/, $_;
    $cnt ++ if ($tokens[0] eq '0');
}
print $cnt;

