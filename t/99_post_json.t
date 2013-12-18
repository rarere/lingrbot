# t/05_post_json.t
use v5.14;
use warnings;
use Test::More;
use HTTP::Request;
use LWP::UserAgent;
use Encode;
use utf8;


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
    $json = '{"status":"ok","counter":208,"events":[{"event_id":208,"message":{"id":82,"room":"myroom","public_session_id":"UBDH84","icon_url":"http://example.com/myicon.png","type":"user","speaker_id":"rarere","nickname":"にっくねーむ","text":"hi!","timestamp":"2011-02-12T08:13:51Z","local_id":"pending-UBDH84-1"}}]}';
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

done_testing;
