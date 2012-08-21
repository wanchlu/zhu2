#!/usr/bin/perl

use strict;


my %feathash;
my $maxfeat = 0;

my $trainFile = shift;


open (TRAIN, "$trainFile");

my $count = 0;

my @featrefs;

while (<TRAIN>) {
  chomp;
  $count++;
  my @feats = split (/\s+/);
  push (@featrefs, \@feats);
}

close TRAIN;


open (NEWTRAIN, ">$trainFile.mis");

for (my $i=0; $i < $#featrefs; $i++) {
  for (my $j=$i+1; $j <= $#featrefs; $j++) {
    my $same = 0;
    for (my $k=0; $k <= $#{$featrefs[$i]}; $k++) {
      if ($featrefs[$i][$k] eq $featrefs[$j][$k]) {
        $same++;
      }
    }
    if ($same > 0) {
      print NEWTRAIN $i+1, "\t", $j+1, "\t$same", "\n";
##      print NEWTRAIN $j+1, "\t", $i+1, "\t$same", "\n";
    }
  }
}

close NEWTRAIN;

