package SinatraAdventCalendar2013;

use v5.14;
use warnings;
use utf8;
use XML::RSS;
use LWP::Simple;
use DateTime;

our $VERSION = "0.02";

# Sinatra Advent Calendar 2013
my $uri = "http://www.adventar.org/calendars/262.rss";

sub get_text {
    my $class = shift;
    my ($text) = @_;

    # 引数なしの場合、今日の記事を探すように文字列を用意
    $text //= "!tekitou sac";

    my @str = split(/ /, $text);
    # 3つ目の文字列がない場合は今日の日付を用意
    $str[2] //= &get_date();

    my $link = "";
    if (defined $str[2]) {
        if ($str[2] =~ /^[0-9]+$/) {
            # 日数
            $link = &get_data_day($str[2]);
        } else {
            # 文字列検索
            $link = &get_data_str($str[2]);
        }
    }

    return $link;
}

sub get_date {
    my $dt = DateTime->now(time_zone => 'local');
    return $dt->day;
}

sub get_data_day {
    my ($day) = @_;

    my $doc = get $uri;
    my $rss = XML::RSS->new;
    $rss->parse($doc);

    my $text = "";
    for my $item (@{$rss->{items}}) {
        $item->{pubDate} =~ /\s?(\d+).*/;
        my $cal_day = $1;

        if ($day == $cal_day) {
            $text = $item->{title} . "\n" .
                    $item->{description} . "\n" .
                    $item->{link} . "\n";
        }
    }
    return $text;
}

sub get_data_str {
    my ($str) = @_;

    my $doc = get $uri;
    my $rss = XML::RSS->new;
    $rss->parse($doc);

    my $text = "";
    my $temptext = "";
    for my $item (@{$rss->{items}}) {
        if ($item->{description} =~ /$str/) {
            $temptext = $item->{title} . "\n" .
                        $item->{description} . "\n" .
                        $item->{link} . "\n";
            $text = $text . $temptext;
        }
    }
    return $text;
}


1;

__END__

