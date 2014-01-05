# t/00_use.t
use v5.14;
use warnings;
use Test::More;
use LingrBot;
use LingrBot::Tekitou;
use LingrBot::Taisho;
use LingrBot::Tenki;
use LingrBot::Help;
use LingrBot::Henji;

use_ok('LingrBot');
use_ok('LingrBot::Tekitou');
use_ok('LingrBot::Taisho');
use_ok('LingrBot::Tenki');
use_ok('LingrBot::Help');
use_ok('LingrBot::Henji');

done_testing;

