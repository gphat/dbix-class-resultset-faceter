package DBIx::Class::ResultSet::Faceter::Facet;
use Moose::Role;

=head1 NAME

DBIx::Class::ResultSet::Faceter::Facet - A Facet

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head1 METHODS

=head2 facet

The facet method is the only required method for something implementing this
role. When faceting the Facet class will be called once for each row in the
ResultSet that is being faceted. It is expected to return a HashRef in the
following form:

  {
    'facet_value' => $count,
  }

This HashRef's key is the facet value that this Facet implementation finds
along with it's count.  Any sorting, limiting, offseting or other operations
are handled by the role and not necessary.

=cut

requires 'facet';

=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2010 Cold Hard Code, LLC

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

__PACKAGE__->meta->make_immutable;

1;