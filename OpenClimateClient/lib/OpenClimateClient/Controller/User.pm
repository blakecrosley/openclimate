package OpenClimateClient::Controller::User;
use Moose;
use namespace::autoclean;

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
    
  if ($form->submitted_and_valid){
    my $parameters = $form->params;
    delete $parameters->{submit};
    
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



=encoding utf8

=head1 AUTHOR

Maxwell Cabral

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
