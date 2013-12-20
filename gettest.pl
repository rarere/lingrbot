# t/05_post_json.t
use v5.14;
use warnings;
use utf8;
use Encode;
use LWP::UserAgent;
use Digest::SHA1 qw(sha1 sha1_hex sha1_base64);


my $ua = LWP::UserAgent->new;
my $room_id = "sinatra_sapporo";
my $bot_id = "tekitounabotto";
my $bot_secret = "kHHewZzMm2xkWMqq5w2f9BPGwFb";
my $bot_verifier = sha1_hex($bot_id . $bot_secret);
my $text = "中は誰もいませんよ";
my $uri = 'http://lingr.com/api/room/say?room=' . $room_id .
          '&bot=' . $bot_id .
          '&text=' . $text .
          '&bot_verifier=' . $bot_verifier;

say $uri;

$ua = LWP::UserAgent->new;
my $response = $ua->get($uri);
if ($response->is_success) {
    print $response->content;  # or whatever
} else {
    die $response->status_line;
}

