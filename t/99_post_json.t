# t/05_post_json.t
use v5.14;
use warnings;
use utf8;
use Encode;
use Test::More;
use HTTP::Request;
use LWP::UserAgent;


my $ua = LWP::UserAgent->new;
my $uri = 'http://localhost/lingrbot/index.cgi';

# set custom HTTP request header
my $req = HTTP::Request->new(POST => $uri);
$req->header('Content-Type' => 'application/json');

# add POST data and HTTP Request
my $json;
my $res;

subtest 'post json' => sub {
    $json = '{"status":"ok","counter":208,"events":[{"event_id":208,"message":{"id":82,"room":"myroom","public_session_id":"UBDH84","icon_url":"http://example.com/myicon.png","type":"user","speaker_id":"dareka","nickname":"nickname","text":"会話してます","timestamp":"2011-02-12T08:13:51Z","local_id":"pending-UBDH84-1"}}]}';
    $json = encode_utf8($json);
    $req->content($json);
    $res = $ua->request($req);

    my $str;
    if ($res->is_success) {
        $str = $res->decoded_content;
    } else {
        $str = $res->code . ":" . $res->message;
    }

    is $str, '';
};

subtest 'post hi!' => sub {
    $json = '{"status":"ok","counter":208,"events":[{"event_id":208,"message":{"id":82,"room":"myroom","public_session_id":"UBDH84","icon_url":"http://example.com/myicon.png","type":"user","speaker_id":"dareka","nickname":"nickname","text":"hi!","timestamp":"2011-02-12T08:13:51Z","local_id":"pending-UBDH84-1"}}]}';
    $req->content($json);
    $res = $ua->request($req);

    my $str;
    if ($res->is_success) {
        $str = $res->decoded_content;
    } else {
        $str = $res->code . ":" . $res->message;
    }

    is $str, 'hi, nickname';
};

subtest 'post hi!(japanese)' => sub {
    $json = '{"status":"ok","counter":208,"events":[{"event_id":208,"message":{"id":82,"room":"myroom","public_session_id":"UBDH84","icon_url":"http://example.com/myicon.png","type":"user","speaker_id":"dareka","nickname":"にっくねーむ","text":"hi!","timestamp":"2011-02-12T08:13:51Z","local_id":"pending-UBDH84-1"}}]}';
    $json = encode_utf8($json);
    $req->content($json);
    $res = $ua->request($req);

    my $str;
    if ($res->is_success) {
        $str = $res->decoded_content;
    } else {
        $str = $res->code . ":" . $res->message;
    }

    is $str, 'hi, にっくねーむ';
};

subtest encode_utf8('post マスター、お茶一杯') => sub {
    my $commandstr = "マスター、お茶一杯";
    $json = '{"status":"ok","counter":208,"events":[{"event_id":208,"message":{"id":82,"room":"myroom","public_session_id":"UBDH84","icon_url":"http://example.com/myicon.png","type":"user","speaker_id":"dareka","nickname":"にっくねーむ","text":"'.  $commandstr . '","timestamp":"2011-02-12T08:13:51Z","local_id":"pending-UBDH84-1"}}]}';
    $json = encode_utf8($json);
    $req->content($json);
    $res = $ua->request($req);

    my $str;
    if ($res->is_success) {
        $str = $res->decoded_content;
    } else {
        $str = $res->code . ":" . $res->message;
    }
    is $str, 'つ お茶';
};

subtest 'post !tekitou' => sub {
    my $commandstr = "!tekitou";
    $json = '{"status":"ok","counter":208,"events":[{"event_id":208,"message":{"id":82,"room":"myroom","public_session_id":"UBDH84","icon_url":"http://example.com/myicon.png","type":"user","speaker_id":"dareka","nickname":"にっくねーむ","text":"'.  $commandstr . '","timestamp":"2011-02-12T08:13:51Z","local_id":"pending-UBDH84-1"}}]}';
    $json = encode_utf8($json);
    $req->content($json);
    $res = $ua->request($req);

    my $str;
    if ($res->is_success) {
        $str = $res->decoded_content;
    } else {
        $str = $res->code . ":" . $res->message;
    }
    is $str, 'コマンド一覧:
hi!
マスター、[任意]一杯
!tekitou tenki [場所]
';
};

subtest 'post !tekitou tenki' => sub {
    my $commandstr = "!tekitou tenki";
    $json = '{"status":"ok","counter":208,"events":[{"event_id":208,"message":{"id":82,"room":"myroom","public_session_id":"UBDH84","icon_url":"http://example.com/myicon.png","type":"user","speaker_id":"dareka","nickname":"にっくねーむ","text":"'.  $commandstr . '","timestamp":"2011-02-12T08:13:51Z","local_id":"pending-UBDH84-1"}}]}';
    $json = encode_utf8($json);
    $req->content($json);
    $res = $ua->request($req);

    my $str;
    if ($res->is_success) {
        $str = $res->decoded_content;
    } else {
        $str = $res->code . ":" . $res->message;
    }
    is $str, 'Usage: !tekitou tenki [場所]';
};

subtest encode_utf8('post !tekitou 札幌市') => sub {
    my $commandstr = "!tekitou tenki 札幌市";
    $json = '{"status":"ok","counter":208,"events":[{"event_id":208,"message":{"id":82,"room":"myroom","public_session_id":"UBDH84","icon_url":"http://example.com/myicon.png","type":"user","speaker_id":"dareka","nickname":"にっくねーむ","text":"'.  $commandstr . '","timestamp":"2011-02-12T08:13:51Z","local_id":"pending-UBDH84-1"}}]}';
    $json = encode_utf8($json);
    $req->content($json);
    $res = $ua->request($req);

    my $str;
    if ($res->is_success) {
        $str = $res->decoded_content;
    } else {
        $str = $res->code . ":" . $res->message;
    }
    is $str, '札幌市
http://weather.livedoor.com/area/forecast/0110000
';
};

done_testing;
