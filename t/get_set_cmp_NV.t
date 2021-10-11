
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

# NOTE: The following applies only to 'doubledouble' NVs.
# If the NV is doubledouble (long double) and Math::MPFR
# is available, then values with binary exponent in the
# range [48 .. 121]are best tested by using Math::MPFR.
# We set $dd to 1 if the NV is doubledouble.
# If Math::MPFR is not available then we currently skip
# the testing of doubledoubles in that exponent range.

$dd = 1 if((2 ** 100) + (2 ** -100) > 2 ** 100); # NV is doubledouble

my $use_mpfr = 0;
eval {require Math::MPFR;};
$use_mpfr = 1 unless $@;
Math::MPFR::Rmpfr_set_default_prec(2098) if ($dd && $use_mpfr);

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

  my $exp = log($n) / log(2);

  $integerize = 1 if $exp <= 121; # The value of $n might not be integer.

  # we invoke use of Math::MPFR for testing only when
  # NV is doubledouble && $exp < 120.6
  my $engage_mpfr = 0;

  $engage_mpfr = 1 if($dd && $exp >= 48 && $exp < 121);

  die "$str numifies to zero"
    if $n == 0;

  die "$str numifies to NaN"
    if $n != $n;

  next if $n / $n != 1; # $n is Inf

  Rmpz_set_NV($z, $n);

  if($dd && $engage_mpfr) {
    next unless $use_mpfr; # Skip testing of this particular doubledouble
                           # value if Math::MPFR is not available.

    my $f = Math::MPFR->new($n);
    Math::MPFR::Rmpfr_rint_roundeven($f, $f, 0); # 0 == Round to Nearest
    my $check = Math::MPFR::Rmpfr_get_NV($f, 0); # 0 == Round to Nearest

    # TODO:
    # For values around 1e15, I'm getting occasional off-by-one ULP differences.
    # For now, when $exp is in the range [47 .. 53], I'll call it a pass if
    # either Rmpfr_rint_roundeven() or Rmpfr_rint_trunc() produces the desired result.

    if( $exp >= 47 && $exp <= 53) {
      if(Rmpz_get_NV($z) != $f) {
        # We'll try Rmpfr_rint_trunc() instead.
        Math::MPFR::Rmpfr_set_NV($f, $n, 0);
        Math::MPFR::Rmpfr_rint_trunc($f, $f, 0);
        $check = Math::MPFR::Rmpfr_get_NV($f, 0);
      }
    }

    cmp_ok(Rmpz_get_NV($z), '==', $f, "Rmpz_get_NV handles $str correctly" );

    cmp_ok(Rmpz_cmp_NV($z, Math::MPFR::Rmpfr_get_NV($f, 0)), '==', 0,
          "Rmpz_cmp_NV compares $str correctly");

  }
  else {
    $check = $integerize ? int($n) : $n;

    cmp_ok(Rmpz_get_NV($z), '==', $check, "Rmpz_get_NV handles $str correctly" );

    cmp_ok(Rmpz_cmp_NV($z, $check / 1.0), '==', 0, "Rmpz_cmp_NV compares $str correctly");
  }
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


