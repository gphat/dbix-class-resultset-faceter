package DBIx::Class::ResultSet::Faceter::Facet;
use Moose::Role;

=head1 NAME

DBIx::Class::ResultSet::Faceter::Facet - A Facet

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head2 name

The name of this facet.  This attribute is required.  It should be unique when
compared to any other facets used on the ResultSet.

=cut

has 'name' => (
    is => 'ro',
    isa => 'Str',
    required => 1
);

=head1 METHODS

=head2 process

The process method is the only required method for something implementing this
role. When faceting the Facet class will be called once for each row in the
ResultSet that is being faceted. It is expected to return a string that will
place it into a facet. Any sorting, limiting, offseting or other operations
are handled by the role and not necessary.

=cut

requires 'process';

=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2010 Cold Hard Code, LLC

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;