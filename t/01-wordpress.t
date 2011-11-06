use Test::More tests => 4;
use WWW::Blog::Identifier;

BEGIN {
    use_ok( 'WWW::Blog::Identifier' ) || print "Bail out!\n";
}

is(WWW::Blog::Identifier->new->identify('http://reuliuilbride.wordpress.com/'), 'wordpress', 'Wordpress site 1');
is(WWW::Blog::Identifier->new->identify('http://blog.blabos.org/'), 'wordpress', 'Wordpress site 2');
isnt(WWW::Blog::Identifier->new->identify('http://googlebrasilblog.blogspot.com/'), 'wordpress', 'NOT Wordpress site 1');

