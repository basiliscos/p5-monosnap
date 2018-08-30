use strict;
use warnings;

use POSIX qw/strftime/;

my $dir = '/tmp/screenshots';
my $mask = '%Y-%m-%d-%H-%M-%S';
my $rn = sprintf('%05d', int(rand(99999)));
my $timestamp = strftime("$mask-$rn", localtime);
my $filename = "$timestamp.png";
my $filepath = "${dir}/$filename";
my $hosting = 'https://monosnap.crazypanda.ru/monosnap/';
my $view_url = "http://service.crazypanda.ru/v/monosnap/${filename}";

mkdir $dir;
system('scrot', '-s', $filepath) == 0 or die("scrot failed: $!");
if (-f $filepath) {
    print "sceenshot has been taken ($filepath)\n";

    system(qw/curl -T/, $filepath, $hosting) == 0 or die("curl failed: $!");
    print "sceenshot has been uploaded\n";

    system('xdg-open', $view_url);

} else {
    die("screenshot $filepath not found");
}
