#! /usr/bin/perl -w
use strict;
use FindBin qw($Bin);
my $biased = 0;
my $input = shift;

my $cnt0 = `$Bin/count_0_std.pl <$input`;
my $cnt1 = `$Bin/count_1_std.pl <$input`;
#chomp ($cnt0, $cnt1);
if ($cnt0 eq '0' or $cnt1 eq '0') {
    $biased = 1;
}elsif ($cnt0 / $cnt1 >= 1.8 or $cnt0 / $cnt1 <= 5/9 ) {
    $biased = 1;
}
print $biased;
