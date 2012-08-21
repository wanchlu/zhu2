#!/usr/bin/perl -w
use strict;

my $suffix = shift;
foreach my $i (1..9) {
    `./tar_file_dir.pl Sun0$i $suffix`;
}
foreach my $i (10..50) {
    `./tar_file_dir.pl Sun$i $suffix`;
}

