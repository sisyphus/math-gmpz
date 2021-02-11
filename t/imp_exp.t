use strict;
use warnings;
use Math::GMPz qw(:mpz);
use Test::More;

print "# Using gmp version ", Math::GMPz::gmp_v(), "\n";

my $z      = Rmpz_init2(50);
my $z_up   = Rmpz_init2(50);
my $z_down = Rmpz_init2(50);

my
$binstring = 'ôW¼+¯·?+ACé??+ÅRHK3V+Ü¦n-¦+üû!é+?k7ß';
Rmpz_import($z, length($binstring), 1, 1, 0, 0, $binstring);
my
 ($order, $size, $endian, $nails) = (1, 1, 0, 0);
my
 $check = Rmpz_export( $order, $size, $endian, $nails, $z);

cmp_ok($check, 'eq', $binstring, "round trip is successful");

utf8::upgrade($binstring);
Rmpz_import($z_up, length($binstring), 1, 1, 0, 0, $binstring);

cmp_ok($z_up, '!=', $z, "utf8::upgrade affects Rmpz_import");

my
 $check_up = Rmpz_export( $order, $size, $endian, $nails, $z_up);

cmp_ok($check_up, 'ne', $check, "utf8::upgrade affects Rmpz_export");

utf8::downgrade($binstring);
Rmpz_import($z_down, length($binstring), 1, 1, 0, 0, $binstring);

cmp_ok($z_down, '==', $z, "utf8::downgrade reverts utf8::upgrade");

done_testing();


