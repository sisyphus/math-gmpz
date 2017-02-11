# Maximum index that can be passed to mpz_setbit, mpz_tstbit, mpz_combit,
# mpz_clrbit, mpz_scan0 and mpz_scan1 is ULONG_MAX.
# If longsize < ivsize, then we need to croak if the UV arg is greater than
# ULONG_MAX. (We assume this gmp behaviour will be fixed in gmp-7.)
# This script checks that the error is being caught, and that bit indexing is
# otherwise working as expected.

use strict;
use warnings;
use Config;
use Math::GMPz qw(:mpz);

if($Config{ivsize} < 8) {
  print "1..1\n";
  warn "Skipping all tests - not relevant to this build of perl\n";
  print "ok 1\n";
  exit 0;
}

print "1..8\n";

warn "\n These tests might take a minute or two to run\n";

my $z0 = Math::GMPz->new(1);
Rmpz_mul_2exp($z0, $z0, 4200000000);
my $z1 = Math::GMPz->new(1);
Rmpz_mul_2exp($z1, $z1, 100000000);
my $z = $z1 * $z0;

my $zero_bit = 0;

if(Rmpz_tstbit($z, 0)) {print "not ok 1\n"}
else {print "ok 1\n"}

eval{Rmpz_setbit($z, 4294967296);};

if($@) {
  if($@ =~ /is greater than maximum allowed value \(4294967295\)/) {print "ok 2\n"}
  else {
    warn "\n\$\@: $@";
    print "not ok 2\n";
  }
}
elsif(Rmpz_tstbit($z, 0)) {
  print "not ok 2\n";
  $zero_bit = 1;
}
else {print "ok 2\n"}

eval{Rmpz_clrbit($z, 4294967296);};

if($@) {
  if($@ =~ /is greater than maximum allowed value \(4294967295\)/) {print "ok 3\n"}
  else {
    warn "\n\$\@: $@";
    print "not ok 3\n";
  }
}
elsif(Rmpz_tstbit($z, 0) != $zero_bit) {print "not ok 3\n"}
else {print "ok 3\n"}

eval{Rmpz_tstbit($z, 4294967296);};

if($@) {
  if($@ =~ /is greater than maximum allowed value \(4294967295\)/) {print "ok 4\n"}
  else {
    warn "\n\$\@: $@";
    print "not ok 4\n";
  }
}
elsif(Rmpz_tstbit($z, 0) != $zero_bit) {print "not ok 4\n"}
else {print "ok 4\n"}

if($Config{sizesize} < 8) {
  warn "\n Skipping test 5 - sizeof(size_t) == 4\n";
  print "ok 5\n";
}
else {
  if(Rmpz_sizeinbase($z, 2) == 4300000001) {print "ok 5\n"}
  else {
    warn "\nsizeinbase 2: ", Rmpz_sizeinbase($z, 2), "\n";
    print "not ok 5\n";
  }
}

eval{Rmpz_combit($z, 4294967296);};

if($Config{longsize} < 8) {
  if($@ =~ /is greater than maximum allowed value \(4294967295\)/) {print "ok 6\n"}
  else {
    warn "\n\$\@: $@";
    print "not ok 6\n";
  }
}
elsif(Rmpz_tstbit($z, 0) == $zero_bit) {print "not ok 6\n"}
else {print "ok 6\n"}

eval{Rmpz_scan0($z, 4294967296);};

if($Config{longsize} < 8) {
  if($@ =~ /is greater than maximum allowed value \(4294967295\)/) {print "ok 7\n"}
  else {
    warn "\n\$\@: $@";
    print "not ok 7\n";
  }
}
else {print "ok 7\n"}

eval{Rmpz_scan1($z, 4294967296);};

if($Config{longsize} < 8) {
  if($@ =~ /is greater than maximum allowed value \(4294967295\)/) {print "ok 8\n"}
  else {
    warn "\n\$\@: $@";
    print "not ok 8\n";
  }
}
else {print "ok 8\n"}

