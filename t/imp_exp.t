use strict;
use warnings;
use Math::GMPz qw(:mpz);
use Test::More;
use Config;

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

$Math::GMPz::utf8_no_warn = 1; # suppress the warning that would tell us $s is UTF8 and
                               # will therefore be subjected to a utf8::downgrade
                               # inside Rmpz_import.

Rmpz_import($z_up, length($s), 1, 1, 0, 0, $s);

cmp_ok($z_up, '==', $z, "Rmpz_import processes downgraded string");

# $s was given a utf8::downgrade inside Rmpz_import.
# Next we check that Rmpz_import restored $s to its original status,
# by doing a utf8::upgrade prior to termination.

cmp_ok(utf8::is_utf8($s), '!=', 0, "Rmpz_import restores upgrade");

my $check_up = Rmpz_export( $order, $size, $endian, $nails, $z_up);

cmp_ok(utf8::is_utf8($check_up), '==', 0, "export returns downgraded string");

cmp_ok($s , 'eq', $check_up, "upgraded string eq downgraqded string");

my $ws = "\x60\x{150}\x90";

$Math::GMPz::utf8_no_warn = 1; # Disable warning.

# $ws is a UTF8 string that cannot be downgraded.
# $Math::GMPz::utf8_no_croak is currently set to 0, so Rmpz_import should
# croak on the "Wide character" when it tries to process $ws.
# Next we check that this is so.

eval{ Rmpz_import($z, length($ws), $order, $size, $endian, $nails, $ws); };
like($@, qr/^Wide character in subroutine/, '$@ set as exected');

$Math::GMPz::utf8_no_croak = 1;
$Math::GMPz::utf8_no_fail = 1;

# With $Math::GMPz::no_croak set to a true value, we verify that
# that Rmpz_import no longer croaks when processing $ws.

eval{ Rmpz_import($z, length($ws), $order, $size, $endian, $nails, $ws); };
cmp_ok($@, 'eq', '', '1: $@ unset as expected');

$Math::GMPz::utf8_no_downgrade = 1;
$Math::GMPz::utf8_no_croak = 0;
$Math::GMPz::utf8_no_fail = 0;

eval{ Rmpz_import($z_up, length($ws), $order, $size, $endian, $nails, $ws); };
cmp_ok($@, 'eq', '', '2: $@ unset as expected');

cmp_ok($z_up, '==', $z, "wide character string without utf8 downgrade treatment ok");

$Math::GMPz::utf8_no_downgrade = 0;

$z_down = Math::GMPz->new((ord('a') * (256 ** 2)) + (ord('B') * 256) + ord('c'));
Rmpz_import($z, 1, $order, 3, 1, $nails, 'aBc');

cmp_ok($z, '==', $z_down, "Rmpz_import basic sanity check");

# ord('a') == 0x61
#If we ignore the 4 most siginificant bits of ord('a') then the value is 0x01
$z_down = Math::GMPz->new((1 * (256 ** 2)) + (ord('B') * 256) + ord('c'));
Rmpz_import($z, 1, $order, 3, 1, 4, 'aBc'); # ignore first 4 bits of 'aBc'

cmp_ok($z, '==', $z_down, "nails test");

my $bits = $Config{ivsize} * 8;
my @uv = (1234567890, 9876543210, ~0, 112233445566);

my $val_check =  Math::GMPz->new($uv[3]) +
                (Math::GMPz->new($uv[2]) <<  $bits) +
                (Math::GMPz->new($uv[1]) << ($bits * 2)) +
                (Math::GMPz->new($uv[0]) << ($bits * 3));

Rmpz_import_UV($z, scalar(@uv), 0, $Config{ivsize}, 0, 0, \@uv);

cmp_ok($z, '==', $val_check, "Rmpz_import_UV basic sanity check");

my @ret = Rmpz_export_UV(0, $Config{ivsize}, 0, 0, $z);

cmp_ok(scalar(@ret), '==', scalar(@uv), "returned array is of expected size");
cmp_ok($ret[0], '==', $uv[0], "1st array elements match");
cmp_ok($ret[1], '==', $uv[1], "2nd array elements match");
cmp_ok($ret[2], '==', $uv[2], "3rd array elements match");
cmp_ok($ret[3], '==', $uv[3], "4th array elements match");


done_testing();

