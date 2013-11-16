package OpenClimateClient;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    Static::Simple
    StackTrace
 
    Authentication
    Authorization::Roles
    
    Session
    Session::Store::File
    Session::State::Cookie
    
    StatusMessage
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in openclimateclient.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'OpenClimateClient',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
    'Plugin::Authentication' => {
        default => {
            class           => 'SimpleDB',
            user_model      => 'DB::User',
            password_type   => 'clear',
        },
    },
    'View::HTML' => {
        #Set the location for TT files
        INCLUDE_PATH => [
            __PACKAGE__->path_to( 'root', 'template' ),
        ],
    },
   'Controller::HTML::FormFu' => {
      request_token_enable => 1,
   }
);

# Start the application
__PACKAGE__->setup(qw/-Debug ConfigLoader Static::Simple/);

=encoding utf8

=head1 NAME

OpenClimateClient - Catalyst based application

=head1 SYNOPSIS

    script/openclimateclient_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<OpenClimateClient::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Maxwell Cabral

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
