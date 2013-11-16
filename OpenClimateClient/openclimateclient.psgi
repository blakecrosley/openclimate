use strict;
use warnings;

use OpenClimateClient;

my $app = OpenClimateClient->apply_default_middlewares(OpenClimateClient->psgi_app);
$app;

