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
    my $parameters = $c->req->parameters;
    delete $parameters->{submit};
    
    $c->model('DB::User')->validate_and_create($parameters);
  
    $c->res->redirect($c->uri_for($self->action_for('index')));  
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
