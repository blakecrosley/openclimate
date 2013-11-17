package OpenClimateClient::Controller::Auth;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::HTML::FormFu'; }

=head1 NAME

OpenClimateClient::Controller::Auth - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 auth_required

Forces the user to sign in before continuing.
Passes the requested URI as a query param so the user can continue on their way post login

=cut

sub auth_required : Private {
  my ($self, $c) = @_;
  
  if (!$c->user){
    $c->session({ error_msg => "You must sign in to continue" });
    $c->res->redirect($c->uri_for_action('/auth/signin',{ next_url => $c->req->uri }));
    $c->detach();
  }
}

=head2 signin

Provides an auth for the for user.
Upon success, redirects the user to the value of the next_url parameter
or their console.

=cut

sub signin :Global :FormConfig('login.yml') :Args(0) {
  my ($self, $c) = @_;
  my $form = $c->stash->{form};
  my $next_uri = $c->req->parameters->{'next_url'};

  $c->res->redirect($c->uri_for_action('/index')) if $c->user_exists();

  # If the username and password values were found in form
  if ($form->submitted_and_valid()) {

    $c->log->info("Auth Form Submitted and valid");

    # Get the username and password from form
    my $username = $form->params->{username};
    my $password = $form->params->{password};

    # Attempt to log the user in
    if ($c->authenticate({ username => $username, password => $password } )) {
        # If successful, then let them use the application
      $c->log->info("Login success");
      $c->session({ status_msg => "Login Success" });
      $c->response->redirect($next_uri || $c->uri_for_action('/console'));
      return;
    } else {
      # Set an error message
      $c->log->info("Login failure");
      $c->session({ error_msg => "Bad username or password." });
    }
  } else {
    # Set an error message
    $c->log->info("Empty username or password.");
    $c->session({ error_mg => "Empty username or password." }) unless $c->user_exists;
  }

  # If either of above don't work out, send to the login page
  $c->stash({
    template => 'login.html'
  });
}

sub signout :Global :Args(0) {
    my ($self, $c) = @_;

    # Clear the user's state
    $c->logout;

    # Send the user to the starting point
    $c->response->redirect($c->uri_for('/'));
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
