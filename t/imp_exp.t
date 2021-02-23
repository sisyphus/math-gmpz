use strict;
use warnings;
use Math::GMPz qw(:mpz);
use Test::More;

print "# Using gmp version ", Math::GMPz::gmp_v(), "\n";

my $z      = Rmpz_init2(50);
my $z_up   = Rmpz_init2(50);
my $z_down = Rmpz_init2(50);

my $s = "\xf4\x57\xbc\x2b\xaf\xb7\x3f\x2b\x41\x43\xe9\x3f\x3f\x2b\xc5\x52\x48\x90";
my ($order, $size, $endian, $nails) = (1, 1, 0, 0);

# $s contains no ordinal values greater than 0xff.
# Therefore utf8::is_utf8($s) should be false.

cmp_ok(utf8::is_utf8($s), '==', 0, "string is not utf8");

Rmpz_import($z, length($s), $order, $size, $endian, $nails, $s);

cmp_ok(utf8::is_utf8($s), '==', 0, "Rmpz_import did not alter format");

my $check = Rmpz_export( $order, $size, $endian, $nails, $z);

cmp_ok($check, 'eq', $s, "round trip is successful");

Rmpz_import($z_down, 2, $order, 9, 1, $nails, $s);
cmp_ok($z_down, '==', $z, "reading in multiple bytes works");

utf8::upgrade($s);

cmp_ok(utf8::is_utf8($s), '!=', 0, "string is utf8");

$Math::GMPz::utf8_no_warn = 1;

Rmpz_import($z_up, length($s), 1, 1, 0, 0, $s);

cmp_ok($z_up, '==', $z, "Rmpz_import processes downgraded string");

cmp_ok(utf8::is_utf8($s), '!=', 0, "Rmpz_import restores upgrade");

my $check_up = Rmpz_export( $order, $size, $endian, $nails, $z_up);

cmp_ok(utf8::is_utf8($check_up), '==', 0, "export returns downgraded string");

cmp_ok($s , 'eq', $check_up, "upgraded string eq downgraqded string");

my $ws = "\x60\x{150}\x90";

$Math::GMPz::utf8_no_warn = 1; # Disable warning.

eval{ Rmpz_import($z, length($ws), $order, $size, $endian, $nails, $ws); };
like($@, qr/^Wide character in subroutine/, '$@ set as exected');

$Math::GMPz::utf8_no_croak = 1;
$Math::GMPz::utf8_no_fail = 1;

eval{ Rmpz_import($z, length($ws), $order, $size, $endian, $nails, $ws); };
cmp_ok($@, 'eq', '', '1: $@ unset as expected');

$Math::GMPz::utf8_no_downgrade = 1;
$Math::GMPz::utf8_no_croak = 0;
$Math::GMPz::utf8_no_fail = 0;

eval{ Rmpz_import($z_up, length($ws), $order, $size, $endian, $nails, $ws); };
cmp_ok($@, 'eq', '', '2: $@ unset as expected');

cmp_ok($z_up, '==', $z, "wide character string without utf8 downgrade treatment ok");

done_testing();

