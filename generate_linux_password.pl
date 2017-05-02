use strict; use warnings;
use Crypt::Passwd::XS;

if( (not defined $ARGV[0]) && (not defined $ARGV[1]) ) {
    print "Usage: script.pl SALT PASSWORD\n";
    die $!;
}

print Crypt::Passwd::XS::crypt($ARGV[1], $ARGV[0])."\n";
