use Test::More;
use strict;

use lib 't/lib';

use FakeResultSet;
use FakeRow;

use DBIx::Class::ResultSet::Faceter;

my $faceter = DBIx::Class::ResultSet::Faceter->new;

$faceter->add_facet('Column', { name => 'Last Name', column => 'name_last' });

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
        )
    ]
);

my $results = $faceter->facet($resultset);

done_testing;