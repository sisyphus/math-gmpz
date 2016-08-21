use strict;
use warnings;
use Math::GMPz qw(:mpz);

print "1..21\n";

#####################################

my $big_uv = ~0;
my $big_uv_mpz = Math::GMPz->new($big_uv);
my $mpz1 = Math::GMPz->new();

if(Rmpz_fits_UV_p($big_uv_mpz)) { print "ok 1\n"}
else {
  warn "$big_uv_mpz does not fit into a UV";
  print "not ok 1\n";
}

if(!Rmpz_fits_IV_p($big_uv_mpz)) { print "ok 2\n"}
else {
  warn "$big_uv_mpz fits into an IV";
  print "not ok 2\n";
}

Rmpz_set($mpz1, $big_uv_mpz + 1);

if(!Rmpz_fits_UV_p($mpz1)) { print "ok 3\n"}
else {
  warn "$mpz1 fits into a UV";
  print "not ok 3\n";
}

if(!Rmpz_fits_IV_p($mpz1)) { print "ok 4\n"}
else {
  warn "$mpz1 fits into an IV";
  print "not ok 4\n";
}

if($big_uv == MATH_GMPz_UV_MAX()) { print "ok 5\n" }
else {
  warn "$big_uv != ", MATH_GMPz_UV_MAX(), "\n";
  print "not ok 5\n";
}

#####################################
#####################################

my $big_iv = ($big_uv - 1) / 2;
my $big_iv_mpz = Math::GMPz->new($big_iv);

if(Rmpz_fits_IV_p($big_iv_mpz)) { print "ok 6\n"}
else {
  warn "$big_iv_mpz does not fit into a IV";
  print "not ok 6\n";
}

if(!Rmpz_fits_IV_p($big_iv_mpz * 2)) { print "ok 7\n"}
else {
  warn "$big_iv_mpz fits into an IV";
  print "not ok 7\n";
}

Rmpz_set($mpz1, $big_iv_mpz + 1);

if(!Rmpz_fits_IV_p($mpz1)) { print "ok 8\n"}
else {
  warn "$mpz1 fits into a IV";
  print "not ok 8\n";
}

if(!Rmpz_fits_IV_p($mpz1 * 4)) { print "ok 9\n"}
else {
  warn "$mpz1 fits into an IV";
  print "not ok 9\n";
}

if($big_iv == MATH_GMPz_IV_MAX()) { print "ok 10\n" }
else {
  warn "$big_iv != ", MATH_GMPz_IV_MAX(), "\n";
  print "not ok 10\n";
}

#####################################
#####################################

my $small_iv = -($big_iv + 1);
my $small_iv_mpz = Math::GMPz->new($small_iv);

if(Rmpz_fits_IV_p($small_iv_mpz)) { print "ok 11\n"}
else {
  warn "$small_iv_mpz does not fit into a IV";
  print "not ok 11\n";
}

if(!Rmpz_fits_IV_p($small_iv_mpz * 2)) { print "ok 12\n"}
else {
  warn "$small_iv_mpz fits into an IV";
  print "not ok 12\n";
}

Rmpz_set($mpz1, $small_iv_mpz - 1);

if(!Rmpz_fits_IV_p($mpz1)) { print "ok 13\n"}
else {
  warn "$mpz1 fits into a IV";
  print "not ok 13\n";
}

if(!Rmpz_fits_IV_p($mpz1 * 4)) { print "ok 14\n"}
else {
  warn "$mpz1 fits into an IV";
  print "not ok 14\n";
}

if($small_iv == MATH_GMPz_IV_MIN()) { print "ok 15\n" }
else {
  warn "$small_iv != ", MATH_GMPz_IV_MIN(), "\n";
  print "not ok 15\n";
}

#####################################

if($big_uv == Math::GMPz->new($big_uv)) {print "ok 16\n"}
else {
  warn "$big_uv != ", Math::GMPz->new($big_uv), "\n";
  print "not ok 16\n";
}

if($big_uv == Math::GMPz->new("$big_uv")) {print "ok 17\n"}
else {
  warn "$big_uv != ", Math::GMPz->new("$big_uv"), "\n";
  print "not ok 17\n";
}

if($big_iv == Math::GMPz->new($big_iv)) {print "ok 18\n"}
else {
  warn "$big_iv != ", Math::GMPz->new($big_iv), "\n";
  print "not ok 18\n";
}

if($big_iv == Math::GMPz->new("$big_iv")) {print "ok 19\n"}
else {
  warn "$big_iv != ", Math::GMPz->new("$big_iv"), "\n";
  print "not ok 19\n";
}

if($small_iv == Math::GMPz->new($small_iv)) {print "ok 20\n"}
else {
  warn "$small_iv != ", Math::GMPz->new($small_iv), "\n";
  print "not ok 20\n";
}

if($small_iv == Math::GMPz->new("$small_iv")) {print "ok 21\n"}
else {
  warn "$small_iv != ", Math::GMPz->new("$small_iv"), "\n";
  print "not ok 21\n";
}
