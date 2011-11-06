#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WWW::Blog::Identifier' ) || print "Bail out!\n";
}

diag( "Testing WWW::Blog::Identifier $WWW::Blog::Identifier::VERSION, Perl $], $^X" );
