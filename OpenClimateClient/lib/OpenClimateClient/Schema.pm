use utf8;
package OpenClimateClient::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07037 @ 2013-11-15 20:26:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Vo6yQWygXFOSXF9ZYSETAA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;