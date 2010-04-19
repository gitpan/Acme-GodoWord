#!perl

use strict;
use warnings;
use utf8;

use Acme::GodoWord;
use Test::More;

is(
    Acme::GodoWord->babelize(q{あなたには見えない}),
    q{【あなた」「には」「見えない】},
);

done_testing;
