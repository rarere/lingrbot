# t/00_use.t
use v5.14;
use warnings;
use Test::More;
use LingrBot;
use LingrBot::Tekitou;
use LingrBot::Nomimono;
use LingrBot::Tenki;

use_ok('LingrBot');
use_ok('LingrBot::Tekitou');
use_ok('LingrBot::Nomimono');
use_ok('LingrBot::Tenki');

done_testing;

