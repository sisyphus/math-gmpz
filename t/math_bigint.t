use strict;
use warnings;
use Math::GMPz qw(:mpz);
use Math::BigInt;

#use Devel::Peek;

print "1..49\n";

#fine with: 1.88, 1.89, 1.999715

my $v = $Math::BigInt::VERSION;
warn "\nUsing Math::BigInt version $v\n";

my $str = '1234567' x 8;

my $bi  = Math::BigInt->new($str);
my $div = Math::BigInt->new(substr($str, 0, 20));
my $add = Math::BigInt->new('100');
my $discard;

my $z = Math::GMPz->new($bi);
my $smaller = $z - 100;

if($z == $str) {print "ok 1\n"}
else {
  warn "\nexpected $str, got $z\n";
  print "not ok 1\n";
}

if($z * $div == $bi * $div) {print "ok 2\n"}
else {
  warn "\nexpected ", $bi * $div, ", got ", $z * $div, "\n";
  print "not ok 2\n";
}

if($z + $div == $bi + $div) {print "ok 3\n"}
else {
  warn "\nexpected ", $bi + $div, ", got ", $z + $div, "\n";
  print "not ok 3\n";
}

if($z / $div == $bi / $div) {print "ok 4\n"}
else {
  warn "\nexpected ", $bi / $div, ", got ", $z / $div, "\n";
  print "not ok 4\n";
}

if($z - $div == $bi - $div) {print "ok 5\n"}
else {
  warn "\nexpected ", $bi - $div, ", got ", $z - $div, "\n";
  print "not ok 5\n";
}

if($z % $div == $bi % $div) {print "ok 6\n"}
else {
  warn "\nexpected ", $bi % $div, ", got ", $z % $div, "\n";
  print "not ok 6\n";
}



my $nan = sqrt(Math::BigInt->new(-17));

eval {if($z == $nan){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_equiv/) {print "ok 7\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 7\n";
}

eval {if($z != $nan){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_not_equiv/) {print "ok 8\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 8\n";
}

############################

eval {$discard = $z & $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_and/) {print "ok 9\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 9\n";
}

if(($z & $div) == ($bi & $div)) {print "ok 10\n"}
else {
  warn "\nexpected ", $bi & $div, ", got ", $z & $div, "\n";
  print "not ok 10\n";
}

############################
############################

eval {$discard = $z | $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_ior/) {print "ok 11\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 11\n";
}

if(($z | $div) == ($bi | $div)) {print "ok 12\n"}
else {
  warn "\nexpected ", $bi | $div, ", got ", $z | $div, "\n";
  print "not ok 12\n";
}

############################
############################

eval {$discard = $z ^ $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_xor/) {print "ok 13\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 13\n";
}

if(($z ^ $div) == ($bi ^ $div)) {print "ok 14\n"}
else {
  warn "\nexpected ", $bi ^ $div, ", got ", $z ^ $div, "\n";
  print "not ok 14\n";
}

############################
############################

eval {if($z > $nan){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_gt/) {print "ok 15\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 15\n";
}

if($z > $div) {print "ok 16\n"}
else {
  warn "\n$z is not greater than $div\n";
  print "not ok 16\n";
}

############################
############################

eval {if($z >= $nan){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_gte/) {print "ok 17\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 17\n";
}

if($z >= $div) {print "ok 18\n"}
else {
  warn "\n$z is not greater than or equal to $div\n";
  print "not ok 18\n";
}

############################
############################

eval {if($z < $nan){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_lt/) {print "ok 19\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 19\n";
}

if($smaller < $bi) {print "ok 20\n"}
else {
  warn "\n$z is not less than to $bi\n";
  print "not ok 20\n";
}

############################
############################

eval {if($z <= $nan){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_lte/) {print "ok 21\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 21\n";
}

if($smaller <= $bi) {print "ok 22\n"}
else {
  warn "\n$z is not less than or equal to $bi\n";
  print "not ok 22\n";
}

############################
############################

eval {if($z <=> $nan){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_spaceship/) {print "ok 23\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 23\n";
}

if($smaller <=> $bi) {print "ok 24\n"}
else {
  warn "\n$z is equal to $bi\n";
  print "not ok 24\n";
}

if(!($z <=> $bi)) {print "ok 25\n"}
else {
  warn "\n$z is not equal to $bi\n";
  print "not ok 25\n";
}

############################
############################

eval {$z ^= $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_xor_eq/) {print "ok 26\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 26\n";
}

#warn "$z\n";

$z  ^= $div;
$bi ^= $div;

#warn "$z\n";

if($z == $bi) {print "ok 27\n"}
else {
  warn "\n$z != $bi\n";
  print "not ok 27\n";
}

############################
############################

eval {$z |= $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_ior_eq/) {print "ok 28\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 28\n";
}

#warn "$z\n";

$z  |= $div * 1000;
$bi |= $div * 1000;

#warn "$z\n";

if($z == $bi) {print "ok 29\n"}
else {
  warn "\n$z != $bi\n";
  print "not ok 29\n";
}

############################
############################

eval {$z &= $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_and_eq/) {print "ok 30\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 30\n";
}

#warn "$z\n";

$z  &= $div * 100;
$bi &= $div * 100;

#warn "$z\n";

if($z == $bi) {print "ok 31\n"}
else {
  warn "\n$z != $bi\n";
  print "not ok 31\n";
}

############################
############################

eval {$z %= $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_mod_eq/) {print "ok 32\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 32\n";
}

$z  %= $div * 100;
$bi %= $div * 100;

if($z == $bi) {print "ok 33\n"}
else {
  warn "\n$z != $bi\n";
  print "not ok 33\n";
}

############################
############################

eval {$z /= $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_div_eq/) {print "ok 34\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 34\n";
}

$z  /= Math::BigInt->new(10);
$bi /= Math::BigInt->new(10);

if($z == $bi) {print "ok 35\n"}
else {
  warn "\n$z != $bi\n";
  print "not ok 35\n";
}

############################
############################

eval {$z -= $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_sub_eq/) {print "ok 36\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 36\n";
}

$z  -= $add;
$bi -= $add;

if($z == $bi) {print "ok 37\n"}
else {
  warn "\n$z != $bi\n";
  print "not ok 37\n";
}

############################
############################

eval {$z += $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_add_eq/) {print "ok 38\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 38\n";
}

$z  += $add;
$bi += $add;

if($z == $bi) {print "ok 39\n"}
else {
  warn "\n$z != $bi\n";
  print "not ok 39\n";
}

############################
############################

eval {$z *= $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_mul_eq/) {print "ok 40\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 40\n";
}

$z  *= $add;
$bi *= $add;

if($z == $bi) {print "ok 41\n"}
else {
  warn "\n$z != $bi\n";
  print "not ok 41\n";
}

############################

eval{$discard = $z * $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_mul/) {print "ok 42\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 42\n";
}

eval{$discard = $z + $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_add/) {print "ok 43\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 43\n";
}

eval{$discard = $z - $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_sub/) {print "ok 44\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 44\n";
}

eval{$discard = $z / $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_div/) {print "ok 45\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 45\n";
}

eval{$discard = $z % $nan};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_mod/) {print "ok 46\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 46\n";
}

my $ninf = Math::BigInt->new(-10) / Math::BigInt->new(0);
my $pinf = Math::BigInt->new(10) / Math::BigInt->new(0);

eval {if($z == $ninf){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_equiv/) {print "ok 47\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 47\n";
}

eval {if($z == $pinf){}};

if($@ =~ /^Invalid Math::BigInt object supplied to Math::GMPz::overload_equiv/) {print "ok 48\n"}
else {
  warn "\n\$\@: $@\n";
  print "not ok 48\n";
}

my $neg = Math::BigInt->new('-1023456');

if($z + $neg == $z - 1023456) {print "ok 49\n"}
else {
  warn "Expected ", $z - 1023456, ", got ", $z + $neg, "\n";
  print "not ok 49\n";
}
