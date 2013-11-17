package OpenClimateClient::Controller::Root;

use namespace::autoclean;

use Try::Tiny;
use Moose;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

OpenClimateClient::Controller::Root - Root Controller for OpenClimateClient

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

sub begin {
  my ($self,$c) = @_;
}

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  $c->stash({
    template => 'home.html',
  })
}

=head2 console

Console page

=cut

sub console :Local {
  my ( $self, $c ) = @_;

  $c->forward('/auth/auth_required');

#  $c->res->redirect($c->uri_for('/signin')) if !$c->user_exists();

  $c->stash({
    template  => 'console.html'
  });
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Maxwell Cabral

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
