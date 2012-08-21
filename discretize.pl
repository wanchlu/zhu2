#!/usr/bin/perl -w
use strict;
my @xes=();
my @ys=();
my $input = shift;
my $size = shift;
open IN, $input or die;
while (<IN>){
    chomp;
    my ($y, $x) = split /\t/;
    push (@xes, $x);
    push (@ys, $y);
}
my $min_x = $xes[0];
my $max_x = $min_x;
my %x_hash;
foreach my $i(0..$#xes) {
    $min_x = $xes[$i] if $min_x > $xes[$i];
    $max_x = $xes[$i] if $max_x < $xes[$i];
    $x_hash{$xes[$i]} = 1;
}
my @keys = keys %x_hash;
my $distinct_x_cnt = $#keys+1;
my $is_discrete = 0;
my @discrete_x; ## 21 elements, 0 - 20, 20 intervals, 
if ($distinct_x_cnt <= $size ) {
    @discrete_x = sort { $a<=> $b;} (keys %x_hash);
    $is_discrete = 1;
}
else {
    my $interval_length = ($max_x - $min_x ) / $size;
    push (@discrete_x, $min_x);
    my $curr = $min_x;
    foreach (1..($size-1)) {
        $curr += $interval_length;
        push (@discrete_x, $curr);
    }
    push (@discrete_x, $max_x);
}

foreach my $ii (0..($#discrete_x-1)) {
    if ($is_discrete == 1) {
        print $discrete_x[$ii];
        foreach my $jj (0..$#xes) {
            if ($xes[$jj] == $discrete_x[$ii]) {
                print "\t$ys[$jj]";
            }
        }
    } else {
        my $med = ($discrete_x[$ii] + $discrete_x[$ii+1]) / 2;
        print $med;
        foreach my $jj (0..$#xes) {
            if ($xes[$jj] >= $discrete_x[$ii] and $xes[$jj] < $discrete_x[$ii+1]) {
                print "\t$ys[$jj]";
            } elsif ($ii == $#discrete_x-1 and $xes[$jj] >= $discrete_x[$ii]) {
                print "\t$ys[$jj]";
            }
        }
    }
    print "\n";
}





