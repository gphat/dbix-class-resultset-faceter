use Test::More;
use strict;

use lib 't/lib';

use FakeResultSet;
use FakeRow;

use DBIx::Class::ResultSet::Faceter;

my $resultset = FakeResultSet->new(
    rows => [
        FakeRow->new(
            name_last => 'Watson'
        ),
        FakeRow->new(
            name_last => 'Smith'
        ),
        FakeRow->new(
            name_last => 'Watson'
        ),
        FakeRow->new(
            name_last => 'Watson'
        ),
		FakeRow->new (
			name_last => 'Brown'
		),
		FakeRow->new (
			name_last => 'Brown'
		)
    ]
);

{
    my $faceter = DBIx::Class::ResultSet::Faceter->new;
    $faceter->add_facet('Column', { name => 'Last Name', column => 'name_last' });
    my $results = $faceter->facet($resultset);

	is_deeply([ { Watson => 3 }, { Brown => 2 }, { Smith => 1 } ], $results->get('Last Name'), 'last name default');
}

done_testing;