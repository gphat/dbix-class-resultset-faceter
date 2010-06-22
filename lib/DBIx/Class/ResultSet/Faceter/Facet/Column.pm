package DBIx::Class::ResultSet::Faceter::Facet::Column;
use Moose;

with 'DBIx::Class::ResultSet::Faceter::Facet';

=head1 NAME

DBIx::Class::ResultSet::Faceter::Facet::Column - Simple faceting on a column

=head1 SYNOPSIS

  $faceter->add_facet('Column', {
	name => 'Last Name', column => 'name_last'
  });

=head1 DESCRIPTION

Returns the value of the specified column.  Used in situations where the facet
desired in the unmodified value of a column.

=head1 ATTRIBUTES

=head2 column

The name of the column to facet on.

=cut

has 'column' => (
    is => 'ro',
    isa => 'Str',
    required => 1
);

=head2 hashref

If true then the row is assumed to be a plain HashRef, as created by the
DBIx::Class HashRefInflator.

=cut

has 'hashref' => (
	is => 'ro',
	isa => 'Bool',
	default => 0
);

=head1 METHODS

=head2 process

Returns the name of the specified column.

=cut

sub process {
    my ($self, $row) = @_;

    my $column = $self->column;

	if($self->hashref) {
		# Treat it like a HashRef
		return $row->{$column};
	}

    return $row->$column;
}

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