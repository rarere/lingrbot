package SinatraAdventCalendar2013;

use v5.14;
use warnings;
use utf8;
use Encode;
use XML::RSS;
use LWP::Simple;
use DateTime;
use DateTime::Format::HTTP;

our $VERSION = "0.01";

sub new {
    my $class = shift;
    my %args = @_;

    my $dt = DateTime->now(time_zone => 'local');
    $args{day} //= $dt->day;
    $args{dt} = DateTime->new(year => 2013, month => 12, day => $args{day});

    # Sinatra Advent Calendar
    my $uri = "http://www.adventar.org/calendars/262.rss";
    my $doc = get $uri;
    my $rss = XML::RSS->new;
    $rss->parse($doc);

    for my $item (@{$rss->{items}}) {
        my $cal_dt = DateTime::Format::HTTP->parse_datetime($item->{pubDate});
        if ($args{dt}->date eq $cal_dt->date) {
            $args{title} = encode_utf8($item->{title});
            $args{description} = encode_utf8($item->{description});
            $args{link} = $item->{link};
        }
    }

    my $self = \%args;
    bless $self, $class;

    return $self;
}

sub get_text {
    my $self = shift;

    my $text;
    if (defined $self->{title}) {
        $text //= $self->{title} . "\n" . 
                  $self->{description} . "\n" .
                  $self->{link};
    } else {
        $text = "";
    }
    return $text;
}

1;

__END__

