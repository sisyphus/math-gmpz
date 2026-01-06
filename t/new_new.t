# Test the feature added in Math-GMPz-0.69 that allows new()
# to be called as a method on an existing Math::GMPz object
# as requested by:
# https://rt.cpan.org/Public/Bug/Display.html?id=167809

use strict;
use warnings;

use Math::BigInt;
use Math::GMPz;

use Test::More;

if($Math::GMPz::VERSION < 0.69) {
  is(1,1);
  warn "Skipping all tests - Math-GMPz-0.69 is required - this is only $Math::GMPz::VERSION\n";
  done_testing();
  exit 0;
}

my $obj = Math::GMPz->new(42);

my($have_gmp, $have_gmpq, $have_mpfr) = (0, 0, 0);

eval{ require Math::GMP;};
$have_gmp = 1 unless $@;

eval{ require Math::GMPq;};
$have_gmpq = 1 unless $@;

eval{ require Math::MPFR;};
$have_mpfr = 1 unless $@;

my $rop = $obj->new(21);
cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 1 ok" );
cmp_ok( $rop, '==', 21, "Test 2 ok" );

$rop = $obj->new('0xff');
cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 3 ok" );
cmp_ok( $rop, '==', 255, "Test 4 ok" );

$rop = $obj->new('ff', 16);
cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 5 ok" );
cmp_ok( $rop, '==', 255, "Test 6 ok" );

my $mbi = Math::BigInt->new(12345678);
$rop = $obj->new($mbi);
cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 7 ok" );
cmp_ok( $rop, '==', 12345678, "Test 8 ok" );

if($have_gmp) {
  my $gmp = Math::GMP->new(87654321);
  $rop = $obj->new($gmp);
  cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 9 ok" );
  cmp_ok( $rop, '==', 87654321, "Test 10 ok" );
}

if($have_gmpq) {
  my $gmpq = Math::GMPq->new('87654323/4');
  $rop = $obj->new($gmpq);
  cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 11 ok" );
  cmp_ok( $rop, '==', 21913580, "Test 12 ok" );
}

if($have_mpfr) {
  my $mpfr = Math::MPFR->new(219135080.8);
  $rop = $obj->new($mpfr);
  cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 13 ok" );
  cmp_ok( $rop, '==', 219135080, "Test 14 ok" );
}

$rop = $obj->new(213.99);
cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 15 ok" );
cmp_ok( $rop, '==', 213, "Test 16 ok" );

$rop = $obj->new(Math::GMPz->new(923));
cmp_ok( ref($rop), 'eq', 'Math::GMPz', "Test 17 ok" );
cmp_ok( $rop, '==', 923, "Test 18 ok" );

eval { $rop = $obj->new(213.99, 16);};
like( $@, qr/^Too many arguments supplied to new()/, "Test 19 ok");

eval { $rop = $obj->new($mbi, 16);};
like( $@, qr/^Too many arguments supplied to new()/, "Test 20 ok");

done_testing();
