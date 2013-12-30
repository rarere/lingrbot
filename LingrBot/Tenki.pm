package Tenki;

use v5.14;
use warnings;
use utf8;
use Encode;
use LWP::UserAgent;
use JSON::PP;

our $VERSION = "0.04";

sub get_text {
    my $class = shift;
    my ($str) = @_;
    $str //= "!tekitou tenki";

    my @search = split(" ", $str);
    return "Usage: !tekitou tenki [場所]" if ($search[1] ne "tenki");
    return "Usage: !tekitou tenki [場所]" if (!defined $search[2]);

    my $file = "./tenkilink.csv";
    my @data;
    my $text = "";
    my $flag = 0;
    open (my $fh, "<", $file)
        or die "Cannot open $file: $!";

    while (my $line = readline $fh) {
        chomp $line;
        @data = split(',',decode_utf8($line));

        if ($data[0] =~ /$search[2]/) {
            $text = $text . $data[0] . "\n" .
                    $data[1] . "\n";
            if ($data[2] eq "1") {
                $text = $text . get_weather($data[1])."\n";
            }
            $flag = 1;
        }
    }
    close $fh;

    return "見つかりませんでした" if ($flag == 0);
    return $text;
}

sub get_weather {
    my ($link) = @_;
    my $id;
    if ($link =~ m|http://weather\.livedoor\.com/area/forecast/(\d+)|) {
        $id = $1;
    }
    my $jsonuri = "http://weather.livedoor.com/forecast/webservice/json/v1?city=" . $id;
    my $ua = LWP::UserAgent->new();
    my $response = $ua->get($jsonuri);

    my $rawjson;
    if ($response->is_success) {
        $rawjson = $response->decoded_content;
    } else {
        return "";
    }
    my $json = decode_json($rawjson);
    my $ret = "";

    for my $f (@{$json->{forecasts}}) {
        # 仕様上、nullの場合があるので""を指定
        $f->{temperature}->{min}->{celsius} //= "";
        $f->{temperature}->{max}->{celsius} //= "";

        $ret = $ret . "$f->{dateLabel}($f->{date}): $f->{telop} " .
               "最低: $f->{temperature}->{min}->{celsius} " .
               "最高: $f->{temperature}->{max}->{celsius}\n";
    }

    return $ret;
}


1;

__END__

