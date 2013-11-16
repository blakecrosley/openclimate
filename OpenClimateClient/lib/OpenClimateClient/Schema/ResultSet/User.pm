package OpenClimateClient::Schema::ResultSet::User;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Try::Tiny;



sub validate_and_create {
  my $self = shift;
  my @rest = @_;
  my $parameters = $rest[0];
  
  die "Missing Parameters\n" unless $parameters;
  
  my $conflict_rs = $self->search({
    -or => [
      username      => $parameters->{username},
      email_address => $parameters->{email_address},
    ],    
  });

  die "User already exists with the given email or username\n" if 0 != $conflict_rs->count;
  
  return $self->create(@rest);
}

1;
