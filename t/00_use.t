# t/00_use.t
use v5.14;
use warnings;
use Test::More;
use LingrBot;
use LingrBot::SinatraAdventCalendar2013;
use LingrBot::Nomimono;

use_ok('LingrBot');
use_ok('LingrBot::SinatraAdventCalendar2013');
use_ok('LingrBot::Nomimono');

done_testing;

