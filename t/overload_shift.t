# Just some tests that overloaded '>>', '>>=', '<<' and '>>='
# on Math::GMPz objects whose value is -ve  work correctly.

use strict;
use warnings;

use Math::GMPz;

use Test::More;

my $z = Math::GMPz->new(-401);
my $rs = $z >> 1;
cmp_ok($rs, '==', -201, " -401 >> 1 works correctly");

$rs = $z << 1;
cmp_ok($rs, '==', -802, " -401 >> 1 works correctly");

cmp_ok($z >> 1, '==', $z << -1, ">> 1 equates to << -1");
cmp_ok($z >> -1, '==', $z << 1, ">> -1 equates to << 1");

$z >>= 1;
cmp_ok($z, '==', -201, " -401 >>= 1 works correctly");

$z >>= -1;
cmp_ok($z, '==', -402, " -201 >>= -1 works correctly");

$z <<= 1;
cmp_ok($z, '==', -804, " -402 <<= 1 works correctly");

$z <<= -1;
cmp_ok($z, '==', -402, " -804 << -1 works correctly");


done_testing();
