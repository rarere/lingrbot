#!/usr/bin/perl -w

use v5.14;
use warnings;
use utf8;
use LingrBot;
use LingrBot::SinatraAdventCalendar2013;

my $bot = LingrBot->new();
my $user = $bot->get_nickname;
my $text = $bot->get_text;

my @str = split(/ /, $text);

if ($text eq 'hi!') {
    $bot->print_text("hi, $user");
} elsif ($str[0] eq '!tekitou') {
    if ($str[1] =~ /sac/) {
        my $sac_link = SinatraAdventCalendar2013->get_text($text);
        $bot->print_text($sac_link);
    }
} else {
    $bot->print_text();
}

