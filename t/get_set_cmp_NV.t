
# Test that Rmpz_get_NV() and Rmpz_set_NV()
# reciprocate as expected.
# Also, provide tests that probe Rmpz_cmp_d()
# and Rmpz_cmp_NV more intensely.
# Finally, test Rmpz_get_d() as it has not
# been tested elsewhere in the test suite.


use strict;
use warnings;
use Config;
use Math::GMPz qw(:mpz);

use Test::More;

my $dd = 0;
$dd = 1 if((2 ** 100) + (2 ** -100) > 2 ** 100); # NV is doubledouble

my $use_mpfr = 0;
eval {require Math::MPFR; Math::MPFR->import(":mpfr"); };
$use_mpfr = 1 unless $@;

my $mpfr_obj;

if($use_mpfr) {
  if($dd) {
    Rmpfr_set_default_prec(2098);
  }
  else {
    Rmpfr_set_default_prec(113);
  }

  $mpfr_obj = Math::MPFR->new();
}

my $z = Math::GMPz->new();

###############################
# Test set and cmp with IV/UV #
###############################

Rmpz_set_NV($z, 123456);

cmp_ok(Rmpz_cmp_NV($z, 123456.0), '==', 0, "compares correctly with equivalent double");
cmp_ok(Rmpz_cmp_NV($z, 123455.999), '>', 0, "compares correctly with smaller double");
cmp_ok(Rmpz_cmp_NV($z, 123456.001), '<', 0, "compares correctly with larger double");
cmp_ok(Rmpz_cmp_NV($z, 123456), '==', 0, "compares correctly with equivalent iv");
cmp_ok(Rmpz_cmp_NV($z, 123455), '>', 0, "compares correctly with smaller iv");
cmp_ok(Rmpz_cmp_NV($z, 123457), '<', 0, "compares correctly with larger iv");

Rmpz_set_NV($z, ~0);

cmp_ok(Rmpz_cmp_NV($z, ~0), '==', 0, "compares correctly with equivalent uv");
cmp_ok(Rmpz_cmp_NV($z, ~0 >> 1), '>', 0, "compares correctly with smaller iv");

################################
################################

my $nv = (2 ** 100) + (2 ** 50);

Rmpz_set_NV($z, $nv);
cmp_ok($nv, '==', Rmpz_get_NV($z), "Rmpz_get_NV returns correct NV");
cmp_ok(Rmpz_cmp_NV($z, $nv), '==', 0, "Rmpz_cmp_NV compares correctly");

Rmpz_set_NV($z, 2.0);
$z **= 16385;

my $t = Rmpz_get_NV($z);

my $is_inf = 0;
$is_inf++ if($t > 0 && $t / $t != 1);

cmp_ok($is_inf, '==', 1, "Rmpz_get_NV() detects and returns 'inf'");
cmp_ok($z, '<', $t, "overloaded comparison 'inf'");
cmp_ok(Rmpz_cmp_NV($z, $t), '<', 0, "Rmpz_cmp_NV compares 'inf' correctly");


Rmpz_set_NV($z, 999.87654321e-3);
cmp_ok($z, '==', 0, "Rmpz_set_NV set correctly for 0 <= NV < 1");

Rmpz_set_NV($z, -999.87654321e-3);
cmp_ok($z, '==', 0, "Rmpz_set_NV set correctly for 0 >= NV > -1");


for(1 .. 6000) {

  my $str = random_string();
  my ($integerize, $check) = (0, 0);

  my $s = $str;
  my $n = $s / 1.0;

  die "$str numifies to zero"
    if $n == 0;

  die "$str numifies to NaN"
    if $n != $n;

  $check = int($n);

  next if $n / $n != 1; # $n is Inf

  Rmpz_set_NV($z, $n);

  if($use_mpfr) {
    Rmpfr_set_NV($mpfr_obj, $n, 0);
    Rmpfr_rint_trunc($mpfr_obj, $mpfr_obj, 0);
    my $nv_check = Rmpfr_get_NV($mpfr_obj, 0);
    cmp_ok(Rmpz_get_NV($z), '==', $nv_check, "Rmpz_get_NV returns the value that mpfr expects");
  }

  cmp_ok(Rmpz_get_NV($z), '==', $check, "Rmpz_get_NV handles $str correctly" );
  cmp_ok(Rmpz_cmp_NV($z, $check), '==', 0, "Rmpz_cmp_NV compares $str correctly");
  if($z != $n) {
    cmp_ok(Rmpz_cmp_NV($z, $n), '<', 0, "$z is less than $n");
    cmp_ok($n - $check, '<', 1, "$check - $z is less than 1");
  }
  cmp_ok(Rmpz_cmp_NV($z, Rmpz_get_NV($z)), '==', 0, "Rmpz_cmp_NV affirms Rmpz_get_NV is retrieving value correctly");
}

unless($Config{nvsize} == 8 || $dd) { # Skip these tests for 'double' and 'doubledouble'
                                      # as the values we're testing here are all Inf on
                                      # on those configurations.

  for(1 .. 100) {

    my $str = random_string_big_exponent();

    my $s = $str;
    my $n = $s / 1.0;

    die "$str numifies to zero"
      if $n == 0;

    die "$str numifies to NaN"
      if $n != $n;

    next if $n / $n != 1; # $n is Inf

    Rmpz_set_NV($z, $n);

    cmp_ok(Rmpz_get_NV($z), '==', int($n), "Rmpz_get_NV handles $str correctly" );
    cmp_ok(Rmpz_cmp_NV($z, int($n) / 1.0), '==', 0, "Rmpz_cmp_NV compares $str correctly");
    cmp_ok(Rmpz_cmp_NV($z, Rmpz_get_NV($z)), '==', 0, "Rmpz_cmp_NV affirms Rmpz_get_NV is retrieving value correctly");

  }
}

done_testing();

sub random_string {
 my $str = '1.';
 for(1 .. 36) { $str .= int(rand(10)) }

 $str .= 'e' . int(rand(500));

 return $str;
}

sub random_string_big_exponent {
 my $str = '1.';
 for(1 .. 36) { $str .= int(rand(10)) }

 $str .= 'e' . (int(rand(1000)) + 4000);

 return $str;
}

__END__

1.345113042674234168859608843877322690e17
