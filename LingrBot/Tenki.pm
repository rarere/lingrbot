package Tenki;

use v5.14;
use warnings;
use utf8;
use Encode;
use LWP::UserAgent;
use JSON::PP;
use DBI;

our $VERSION = "0.06";

sub get_text {
    my $class = shift;
    my ($str) = @_;
    $str //= "!tekitou tenki";

    my @search = split(" ", $str);

    return "Usage: !tekitou tenki [場所]" if ($search[1] ne "tenki");
    return "Usage: !tekitou tenki [場所]" if (!defined $search[2]);

    my $text = weather_text($search[2]);
    return $text;
}

sub weather_text {
    my ($search) = @_;

    my $weatherurl = selectdb($search);

    my $text = "";
    my $flag = 0;

    for my $line (@$weatherurl) {
        my @data = split(',',decode_utf8($line));

        $text = $text . $data[0] . "\n" .
                $data[1] . "\n";
        if ($data[2] eq "1") {
            $text = $text . get_weather($data[1])."\n";
        }
        $flag = 1;
    }

    if ($flag == 0) {
        $text = "見つかりませんでした";
    }
    return $text;
}

sub selectdb {
    my ($search) = @_;
    if ($search =~ /[a-zA-Z0-9_]+/) {
        $search =~ tr/A-Z/a-z/;
        $search .= "\%";
    } else {
        $search = "\%$search\%";
    }

    my $file = "./tenkilink.db";
    my $dbh = DBI->connect("dbi:SQLite:dbname=$file", undef, undef, {
            AutoCommit => 1, RaiseError => 1, PrintError => 0, });
    my $sql = <<EOS;
select distinct 
t_name.name_kanji, t_link.url, t_link.tenki_flag from t_name 
left outer join t_link on t_name.link_id  = t_link.id
where name like ?
order by t_link.id asc;
EOS
    my $sth = $dbh->prepare($sql);
    $sth->execute($search) or die "Error: " . $dbh->errstr;

    my $array;
    while (my $array_ref = $sth->fetchrow_arrayref) {
        my ($name, $url, $flag) = @$array_ref;
        push(@$array, "$name,$url,$flag");
    }
    $dbh->disconnect();

    return $array;
}


sub get_weather {
    my ($link) = @_;
    my $id;
    if ($link =~ m|http://weather\.livedoor\.com/area/forecast/(\d+)|) {
        $id = $1;
    } else {
        return "";
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

