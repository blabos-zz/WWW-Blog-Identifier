package WWW::Blog::Identifier;

use 5.012;
use strict;
use warnings;

use LWP::Simple;
use JSON;
use Try::Tiny;

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

=cut

sub new {
    my $class   = shift;
    my $args    = shift;
    my $atts    = {};
    
    return bless $atts, $class;
}

sub identify {
    my $self    = shift;
    my $url     = shift;
    
    my $engine = '';
    
    # For Poste
    try {
        my $uri     = URI->new( $url );
        my $scheme  = $uri->scheme;
        my $host    = $uri->host;
        my $port    = $uri->port;
        $port = $port > 0 ? ":$port" : '';
        
        my $info = decode_json get "http://$host$port/about.json";
        
        $engine = $info->{name};
    }
    catch {
        warn $_;
        $engine = '';
    };
    
    return $engine if length $engine > 0;
    
    # For Wordpress
}

=head2 function2

=cut

sub function2 {
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
