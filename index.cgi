#!/usr/bin/perl -w

use v5.18;
use strict;
use warnings;
use utf8;
use LingrBot;
use SinatraAdventCalendar2013;
use DateTime;
use Encode;

my $bot = LingrBot->new();
my $user = $bot->get_nickname;
my $text = $bot->get_text;

my @str = split(/ /, $text);

if ($text eq 'hi!') {
    $bot->print_text("hi, $user");
} elsif ($str[0] eq '!tekitou') {
    if ($str[1] =~ /sinatra/) {
        my $sac;
        if (defined $str[2]) {
            $sac = SinatraAdventCalendar2013->new(day => $str[2]);
        } else {
            $sac = SinatraAdventCalendar2013->new();
        }
        print "Content-type: text/plain\n\n";
        print $sac->get_text."\n";
    }
} else {
    $bot->print_text();
}

