#!/usr/bin/perl -w
use strict;

my $supdir = shift;
my $suffix = shift;
`tar -zcf $supdir.$suffix.tar.gz $supdir/*/*/*$suffix`;

