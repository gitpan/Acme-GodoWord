#!perl

use strict;
use warnings;
use utf8;

use Acme::GodoWord;
use Test::More;

is_deeply(
    [ Acme::GodoWord->tokenize('あなたには見えない') ],
    [ 'あなた', 'には', '見えない'],
);

done_testing;
