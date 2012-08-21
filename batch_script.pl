#!/usr/bin/perl -w
use strict;
my $script = shift;

foreach my $i (1..9) {
    `./$script Mon0$i`
}
foreach my $i (10..50) {
    `./$script Mon$i`
}
