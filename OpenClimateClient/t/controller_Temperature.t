use strict;
use warnings;
use Test::More;


use Catalyst::Test 'OpenClimateClient';
use OpenClimateClient::Controller::Temperature;

ok( request('/temperature')->is_success, 'Request should succeed' );
done_testing();
