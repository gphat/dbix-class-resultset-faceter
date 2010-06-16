use Test::More;
use strict;

my $faceter = DBIx::Class::ResultSet::Faceter->new();

$faceter->add_facet('Column', { column => 'name_first' });

my $resultset;

my $results = $faceter->facet($resultset);

done_testing;