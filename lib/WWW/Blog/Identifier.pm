package WWW::Blog::Identifier;

use 5.012;
use strict;
use warnings;

use LWP::Simple;
use JSON;
use Try::Tiny;

use WWW::Blog::Identify;

=head1 NAME

WWW::Blog::Identifier - The great new WWW::Blog::Identifier!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use WWW::Blog::Identifier;

    my $foo = WWW::Blog::Identifier->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 new

Constructor

=cut

sub new {
    my $class   = shift;
    my $args    = shift;
    my $atts    = {};
    
    return bless $atts, $class;
}


=head2 identify

Identify

=cut
sub identify {
    my $self    = shift;
    my $url     = shift;
    
    my $engine = '';

	my $get_basename = sub {
        my $uri     = URI->new( shift );
        my $scheme  = $uri->scheme;
        my $host    = $uri->host;
        my $port    = $uri->port;
        $port = $port > 0 ? ":$port" : '';
		return ("$scheme://$host$port", $host);
	};

	my $flavor = WWW::Blog::Identify::identify $url, '';
	return $flavor if ($flavor && $flavor !~ /suspected/);
		
    # For Poste
    try {
		my $info = decode_json get $get_basename->($url) . '/about.json';
        
        $engine = $info->{name};
    }
    catch {
    };

	my $html;

    # For Wordpress
	try {
		my ($site, $host) = $get_basename->($url);
		if ($host =~ /\.wordpress\./ ) {
			$engine = 'wordpress';
		}else{
			my $html_wp = get "$site/readme.html";

			if ($html_wp && $html_wp =~ m|<title>WordPress|io){
				$engine = 'wordpress';
			}else{
				$html ||= get $url;
				$engine = 'wordpress' if $html =~ m|<meta name="generator" content="WordPress|io;
			}
		}
    }
    catch {
    };

	$html ||= get $url;
	$flavor = WWW::Blog::Identify::identify '', $html;
	return $flavor if ($flavor && $flavor !~ /suspected/);


    return $engine if length $engine > 0;

}

=head1 AUTHOR

Blabos de Blebe, C<< <blabos at cpan.org> >>
Renato Cron, C<< <renato.cron at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-blog-identifier at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Blog-Identifier>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Blog::Identifier


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Blog-Identifier>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Blog-Identifier>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Blog-Identifier>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Blog-Identifier/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Blabos de Blebe.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of WWW::Blog::Identifier
