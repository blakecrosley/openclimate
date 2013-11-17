package OpenClimateClient::Controller::Temperature;

use namespace::autoclean;

use DateTime;
use Moose;
use Try::Tiny;

BEGIN { extends 'Catalyst::Controller::REST'; }

=head1 NAME

OpenClimateClient::Controller::Temperature - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 BEGIN

=cut

=head1 METHODS

=cut

sub save : Path('save') : Args(0) : ActionClass('REST') { }
sub get : Path('get') : Args(0) :ActionClass('REST') {}

sub get_GET {
  my ( $self, $c ) = @_;

  my @temp_list = $c->model('DB::Temperature')->search({
  },{
    rows => 60,
  });

  my @values;

  foreach my $item ( @temp_list ) {
    push @values, [ $item->timestamp->minute, $item->temperature ]
  }

  $self->status_ok(
    $c,
    entity => {
      label => 'Live Temperature Reading',
      data => \@values,
    }
  );
}

=head2 save_temperature

=cut

sub save_POST {
  my ( $self, $c ) = @_;

  my $temperature = $c->request->param('temperature');

  try {
    $c->model('DB::Temperature')->create({
      temperature => $temperature
    });

    $self->status_created(
      $c,
      location => $c->req->uri,
      entity => {
        message => "Temperature saved."
      }
    );
  } catch {
    $c->log->info("Could not save this point, error: $_");

    $self->status_bad_request(
      $c,
      message => "Could not save this temperature."
    );
  }
}


=encoding utf8

=head1 AUTHOR

Grigor Karavardanyan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
