#!/usr/bin/env perl
use strict; use warnings;
use Crypt::Passwd::XS;
use Algorithm::Combinatorics qw(combinations);

my $charset = [qw(a b c d e f g h i j k l m n o p q r s t u v w x y z)];
my $salt;
my $hash;
my $n;

sub help() {
    print "Usage: $0 <SALT> <SALT+HASH> <N>\n";
    print 'SALT = $6$193ZnhKD$'."\n";
    print 'HASH = $6$193ZnhKD$h9X42e2JRjfLVXhmdT72MSgSfXL5uTQ8UkA4BISUIIQcF4aJTEqttbcnTK4qD/jvkRPRTCmsqYlcEBPy2Zl551'."\n";
    print 'N = Length of password.'."\n";
}

sub check_args() {
    if( (defined $ARGV[0]) && ($ARGV[0] eq "-h") ) {
        help();
    }

    if(not defined $ARGV[0]) {
        print "Specify the salt: ";
        $salt = <STDIN>;
        chomp $salt;
    } else {
        $salt = $ARGV[0];
    }

    if(not defined $ARGV[1]) {
        print "Specify the target hash: ";
        $hash = <STDIN>;
        chomp $hash;
    } else {
        $hash = $ARGV[1];
    }

    if(not defined $ARGV[2]) {
        print "Specify the password length: ";
        $n = <STDIN>;
        chomp $n;
    } else {
        $n = $ARGV[2];
    }

}

sub main() {
    check_args();
    my $iter = combinations($charset, 6);
    my $index = 0;
    print "Initiating brute-force attack on crypt hashes ...\n";
    while (my $c = $iter->next) {
        my $combination = join('',@$c);
        my $computed_hash = Crypt::Passwd::XS::crypt($combination, $salt);
        $index++;

        if (($index % 2) == 0) {
            print "Current password: $combination\r"
        }

        if ( $computed_hash eq $hash) {
            print "Found password: $combination\n";
            exit 0;
        }
    }
    print "Password was not found.\n";
    exit 1;
}

main();
