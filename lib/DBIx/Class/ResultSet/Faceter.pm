package DBIx::Class::ResultSet::Faceter;
use Moose;

use Class::MOP;

=head1 NAME

DBIx::Class::ResultSet::Faceter - Faceting for DBIx::Class ResultSets

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head2 facets

=cut

has 'facets' => (
    traits => [ qw(Array) ],
    is => 'ro',
    isa => 'ArrayRef',
    default => sub { [] }
);

=head1 METHODS

=head2 add_facet

Add a facet to this faceter.

=cut

sub add_facet {
    my $self = shift;

    my $facet;
    if(scalar(@_) == 1) {
        # If we only have one argument, it has to be something that does facet
        try {
            $_[0]->does('DBIx::Class::Faceter::Facet');
        } catch {
            die 'Single arguments to add_facet must implement the DBIx::Class::Faceter::Facet role';
        }
        $facet = shift;
    } else {
        # If we have anything else we'll assume the first argument is the name
        # of the class and the rest of the args are arguments to said class.
        my $class = shift;
        die "First argument to add_facet should be a string class name if it isn't an instance" unless defined($class) && !ref($class);

        # Attempt to load the class.  If it has a + on the front, we'll treat
        # it like a fully qualified class name.
        if($class =~ /^\+/) {
            # Strip off the unary plus and load that
            $class =~ s/^\+//g;
        } else {
            $class = "DBIx::Class::ResultSet::Faceter::$class";
        }

        try {
            Class::MOP::load_class($class);
            # Instantiate the damned thing with the leftover arguments, but do
            # it in this try so if it blows up we can report the failure.
            $facet = $class->new(@_);
        } catch {
            die "Tried to load the class '$class' as a Facet and failed: $_";
        }
    }

    push(@facets, $facet);
}

=head2 facet

Performs the faceting, returning a L<DBIx::Class::Faceter::Result> object.

=cut

sub facet {
    my ($self, $rs) = @_;

    while(my $row = $rs->next) {
        foreach my $facet (@{ $self->facets }) {
            $facet->process($rs);
        }
    }
}

=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 ACKNOWLEDGEMENTS

Jay Shirley

=head1 COPYRIGHT & LICENSE

Copyright 2010 Cold Hard Code, LLC

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

__PACKAGE__->meta->make_immutable;

1;
