package DBIx::Class::ResultSet::Faceter::Result;
use Moose;

=head1 NAME

DBIx::Class::ResultSet::Faceter::Facet - The result of a faceting operation

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head2 count

The number of facets in this result.

=head2 facets

An ArrayRef of facets in the form of:

  [
    { 'facet_value_A' => $count_A },
    { 'facet_value_B' => $count_B }
  ]

=cut

has 'facets' => (
    traits => [ qw(Array) ],
    is => 'ro',
    isa => 'ArrayRef',
    default => sub { [] },
    handles => {
        count => 'count'
    }
);

=head2 facet_names

An array of facet names, returned in the same order that they appear in
C<facets>.

=cut

has 'names' => (
    is => 'ro',
    isa => 'ArrayRef',
    lazy => 1,
    default => sub {
        # There is probably a less verbose way to do this...
        my $self = shift;
        my @names = ();
        foreach my $f (@{ $self->facets }) {
            my @keys = keys(%{ $f });
            push(@names, $keys[0]);
        }
        return \@names;
    }
);

=head1 METHODS

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