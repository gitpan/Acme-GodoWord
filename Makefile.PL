use inc::Module::Install;

use strict;
use warnings;

name 'Acme-GodoWord';
all_from 'lib/Acme/GodoWord.pm';

requires 'Text::TinySegmenter';

tests 't/*.t';
author_tests('xt');

build_requires 'Test::More';

auto_include;
auto_install;

WriteAll;
