package OpenClimateClient::Controller::User;

use namespace::autoclean;

use Moose;
use Try::Tiny;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

OpenClimateClient::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
  my ($self, $c) = @_;
  $c->res->redirect($c->uri_for_action('/index'));
}

=head2 create

=cut

sub create :Local :FormConfig('user/create.yml') :Args(0) {
  my ( $self, $c ) = @_;
  my $form = $c->stash->{form};

  $c->res->redirect($c->uri_for_action('/index')) if $c->user_exists();

  if ($form->submitted_and_valid){
    my $parameters = $form->params;
    delete $parameters->{submit};
    delete $parameters->{_token};

    my $error;
    try {
      my $user = $c->model('DB::User')->validate_and_create($parameters);
      $c->authenticate({ username => $user->username, password => $parameters->{password} });
    } catch {
      $error = $_;
      $c->session({ error_message => "Unable to create user: $error" });
    };

    unless ($error) {
      $c->res->redirect($c->uri_for($self->action_for('index'))) unless $error;
      $c->session({ status_msg => "Login Success" });
    }
  }

  $c->stash({
    template => 'user/create.html',
  });
}

=head2 profile

=cut

sub profile :Local :FormConfig('user/profile.yml') :Args(0) {
  my ( $self, $c ) = @_;
  my $form = $c->stash->{form};

  $c->forward('/auth/auth_required');

  $form->default_values({
    first_name      => $c->user->first_name,
    last_name       => $c->user->last_name,
    username        => $c->user->username,
    email_address   => $c->user->email_address,
  });
  
  if ($form->submitted_and_valid){
    my $params = $form->params;
    delete $params->{_token};
    delete $params->{old_password};
    delete $params->{password_confirmation};
    $c->user->_user->update($params);
    $c->stash({ status_msg => 'Profile Updated' });
    $c->res->redirect($c->uri_for($self->action()));
  }
  
  $c->stash({
    template => 'user/profile.html',
  });
}


=encoding utf8

=head1 AUTHOR

Maxwell Cabral

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
