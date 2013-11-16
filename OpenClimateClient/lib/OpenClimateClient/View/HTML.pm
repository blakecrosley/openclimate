package OpenClimateClient::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.html',
    render_die => 1,
    INCLUDE_PATH => [
      OpenClimateClient->path_to( 'root', 'template' ),
    ],
    # Set to 1 for detailed timer stats in your HTML as comments
    TIMER              => 0,
    # This is your wrapper template located in the 'root/src'
    WRAPPER => 'wrapper.html',
);

=head1 NAME

OpenClimateClient::View::HTML - TT View for OpenClimateClient

=head1 DESCRIPTION

TT View for OpenClimateClient.

=head1 SEE ALSO

L<OpenClimateClient>

=head1 AUTHOR

Maxwell Cabral

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
