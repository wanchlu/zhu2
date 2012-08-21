#!/usr/bin/perl

use IO::Handle;

autoflush STDOUT 1;
my $trainfile = shift;
my $testfile = shift;
my $testsize = shift;
my $stepsize = shift;
my $biased = 1;
while ($biased ne 0) {
    `shuffle.pl $testfile | head -n$testsize >$testfile.$testsize`;
    $biased = `./data/is_biased_file.pl $testfile.$testsize`;
}
$testfile = "$testfile.$testsize";


my $MAXIT = 100;
my $time = localtime(time);
$time =~ s/\W+//g;
$time =~ s/2012//g;
$time =~ s/Aug\d\d//g;

#for my $trainsize (5, 10, 15, 20, 25, 50, 75, 100, 150, 200, 250, 300, 350, 400, 450, 500) {
`mkdir $time`;
`cp $testfile $time/test`;
`./data/convert_to_zhu_format_single.pl "$time/test"`;

#for my $trainsize (1..20) {
my $trainsize = 2;
while ( $trainsize <= $testsize ) {

    my $old_trainfile = '';
    unless ($trainsize == 2) {
        my $pre_trainsize = $trainsize - $stepsize;
        my $pre_tag = "$time/train$pre_trainsize"."test$testsize/0";
        $old_trainfile = "$pre_tag/train";
        $trainfile = "$pre_tag/comp";
    }

    for (my $iter = 0; $iter < $MAXIT; $iter++) {
        my $tag = "$time/train$trainsize"."test$testsize/$iter";
        `mkdir -p $tag` unless (-d $tag);

        if ($trainsize == 2) {
            `./data/convert_to_zhu_format_first.pl $trainfile $trainsize $testfile`;
        }
        else {
            `./data/convert_to_zhu_format_addition.pl $trainfile $trainsize $old_trainfile $testfile`;
        }

        my $f1 = `./zhu -graph $trainfile.$trainsize.sim -trainlabels $trainfile.$trainsize.labels -testlabels $testfile.labels -out zhu.out -classes 2`;

        chomp($f1);

        $f1 =~ m/.*:\s+(.*)$/;

        `cp $trainfile.$trainsize.sim $tag/sim`;
        `mv zhu.out $tag/out`;
        `echo "$f1" > $tag/acc`;
        `cp $trainfile.$trainsize.shuffle $tag/train`;
        `cp $testfile $tag/test`;
        if ($iter == 0) {
            `cp $trainfile.$trainsize.comp.shuffle $tag/comp`;
        }
        `./data/convert_to_zhu_format_single.pl $tag/train`;
    }
    $trainsize = $trainsize + $stepsize;
}

`rm -fr $time/*/*shuffle`;
`rm -fr ./data/zhu/subset/*shuffle ./data/zhu/subset/*labels ./data/zhu/subset/*sim ./data/zhu/subset/*devtt\.*`;

