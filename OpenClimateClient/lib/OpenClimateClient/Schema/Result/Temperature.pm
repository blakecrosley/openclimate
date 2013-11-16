use utf8;
package OpenClimateClient::Schema::Result::Temperature;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

OpenClimateClient::Schema::Result::Temperature

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<temperature>

=cut

__PACKAGE__->table("temperature");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 temperature

  data_type: 'decimal'
  is_nullable: 1
  size: [4,2]

=head2 timestamp

  data_type: 'datetime'
  default_value: current_timestamp
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "temperature",
  { data_type => "decimal", is_nullable => 1, size => [4, 2] },
  "timestamp",
  {
    data_type     => "datetime",
    default_value => \"current_timestamp",
    is_nullable   => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07037 @ 2013-11-16 13:39:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ESHqKblNio6x5lmHw1DPRg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
