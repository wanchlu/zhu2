#!/usr/bin/perl -w
use strict;

my $suffix = shift;
foreach my $i (1..9) {
    `tar -zxf Mon0$i.$suffix.tar.gz`;
}
foreach my $i (10..50) {
    `tar -zxf Mon$i.$suffix.tar.gz`;
}

