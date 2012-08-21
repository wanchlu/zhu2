#!/usr/bin/perl -w
use strict;

my $edgelist = shift;
my $trainsize = shift;
my $num_nodes = 0;
my %degree = ();
my %adj = ();

open IN, $edgelist or die;
while (<IN>) {
    chomp;
    my ($v1, $v2, $w) = split /\s+/;
    $degree{$v1} = 0 if not exists $degree{$v1};
    $degree{$v1} ++;
    $num_nodes = $v1 if $num_nodes < $v1;
    $degree{$v2} = 0 if not exists $degree{$v2};
    $degree{$v2} ++;
    $num_nodes = $v2 if $num_nodes < $v2;
    $adj{$v1}{$v2} = $w;
    $adj{$v2}{$v1} = $w;
}
close IN;

my $sum_d = 0;
my $sum_cl = 0;
my $avg_d = 0;
my $avg_cl = 0;
for (my $i = 1; $i <= $trainsize; $i ++) {
    next if not exists $degree{$i};
    if ($degree{$i} == 1) {
        $sum_d ++;
    }else {
        $sum_d += $degree{$i};
        my $e_jk = 0;
        my @neighbors = keys %{$adj{$i}};
        foreach my $j (0..($#neighbors-1)) {
            foreach my $k (($j+1)..$#neighbors) {
                if (exists $adj{$neighbors[$j]}{$neighbors[$k]}) {
                    $e_jk ++;
                }
            }
        }
        $sum_cl += 2 * $e_jk / ($degree{$i} * ($degree{$i} - 1));
    }
}
$avg_d = $sum_d / $trainsize;
$avg_cl = $sum_cl / $trainsize;
print "$avg_d\t$avg_cl";



