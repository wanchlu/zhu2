#!/usr/bin/perl -w
use strict;

my $supdir = shift;
my @subdirs = `ls $supdir`;
chomp(@subdirs);

foreach my $d (@subdirs) {
    next unless ($d =~ m/^train\d/);
    my $dir = $supdir.'/'.$d;

    `cat $dir/*/acc | cut -d" " -f6 >ttt01`;
    `cat $dir/*/stats |grep diameter | cut -d" " -f4 >ttt02`;
    `cat $dir/*/ttats |grep diameter | cut -d" " -f4 >ttt03`;
    `cat $dir/*/stats |grep average | grep degree | cut -d" " -f5 >ttt04`;
    `cat $dir/*/ttats |grep average | grep degree | cut -d" " -f5 >ttt05`;
    `cat $dir/*/stats |grep components | cut -d" " -f6 >ttt06`;
    `cat $dir/*/ttats |grep components | cut -d" " -f6 >ttt07`;
    `cat $dir/*/stats |grep Watts | cut -d" " -f9 >ttt08`;
    `cat $dir/*/ttats |grep Watts | cut -d" " -f9 >ttt09`;
    `cat $dir/*/stats |grep Newman |grep clustering | cut -d" " -f8 >ttt10`;
    `cat $dir/*/ttats |grep Newman |grep clustering | cut -d" " -f8 >ttt11`;
    `cat $dir/*/stats |grep Ferrer | cut -d" " -f8 >ttt12`;
    `cat $dir/*/ttats |grep Ferrer | cut -d" " -f8 >ttt13`;
    `cat $dir/*/stats |grep distance: | cut -d" " -f7  >ttt14`;
    `cat $dir/*/ttats |grep distance: | cut -d" " -f7  >ttt15`;
    `cat $dir/*/stats |grep full | cut -d" " -f7 >ttt16`;
    `cat $dir/*/ttats |grep full | cut -d" " -f7 >ttt17`;
    `cat $dir/*/labeled | cut -f1 >ttt18`; # degree of labeled examples
    `cat $dir/*/labeled | cut -f2 >ttt19`; # local clustering coeff. of labeled examples
    `paste ttt* >"$dir/table"`;
    `rm  ttt*`;
}
