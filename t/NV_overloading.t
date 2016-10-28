# Mainly want to test that:
# inf and nan are handled correctly when passed to overloaded subs (including when they're passed as strings)
# valid floating point NV's are handled correctly when passed to overloaded subs
# valid floating point values are a fatal error when passed as a string

use strict;
use warnings;
use Math::GMPz;

print "1..14\n";

my $inf  = 999 ** (999 ** 999);
my $ninf = $inf * -1;
my $nan  = $inf / $inf;
my $strinf = 999 ** (999 ** 999);
my $strnan = $strinf / $strinf;
my ($ret, $x);

eval{$ret = Math::GMPz->new(10) *  $inf };
eval{$ret = Math::GMPz->new(10) * "$strinf"};
eval{$ret = Math::GMPz->new(10) *  $nan };
eval{$ret = Math::GMPz->new(10) * "$strnan"};
eval{$ret = Math::GMPz->new(10) * "61.2"};

if(Math::GMPz->new(10) * 61.2 == 610) {print "ok 6\n"}
else {
  warn "\n Expected 610\nGot: ", Math::GMPz->new(10) * 61.2, "\n";
  print "not ok 6\n";
}

eval{$ret = Math::GMPz->new(10) +  $inf };
eval{$ret = Math::GMPz->new(10) + "$strinf"};
eval{$ret = Math::GMPz->new(10) +  $nan };
eval{$ret = Math::GMPz->new(10) + "$strnan"};
eval{$ret = Math::GMPz->new(10) + "61.2"};

if(Math::GMPz->new(10) + 61.2 == 71) {print "ok 12\n"}
else {
  warn "\n Expected 71\nGot: ", Math::GMPz->new(10) + 61.2, "\n";
  print "not ok 12\n";
}

eval{$ret = Math::GMPz->new(10) /  $inf };
eval{$ret = Math::GMPz->new(10) / "$strinf"};
eval{$ret = Math::GMPz->new(10) /  $nan };
eval{$ret = Math::GMPz->new(10) / "$strnan"};
eval{$ret = Math::GMPz->new(10) / "61.2"};

if(Math::GMPz->new(10) / 61.2 == 0) {print "ok 18\n"}
else {
  warn "\n Expected 0\nGot: ", Math::GMPz->new(10) / 61.2, "\n";
  print "not ok 18\n";
}

eval{$ret = Math::GMPz->new(10) -  $inf };
eval{$ret = Math::GMPz->new(10) - "$strinf"};
eval{$ret = Math::GMPz->new(10) -  $nan };
eval{$ret = Math::GMPz->new(10) - "$strnan"};
eval{$ret = Math::GMPz->new(10) - "61.2"};

if(Math::GMPz->new(10) - 61.2 == -51) {print "ok 24\n"}
else {
  warn "\n Expected -51\nGot: ", Math::GMPz->new(10) - 61.2, "\n";
  print "not ok 24\n";
}

$ret = Math::GMPz->new(10);

eval{$ret *=  $inf };
eval{$ret *= "$strinf"};
eval{$ret *=  $nan };
eval{$ret *= "$strnan"};
eval{$ret *= "61.2"};

$ret *= 61.2;

if($ret == 610) {print "ok 30\n"}
else {
  warn "\n Expected 610\nGot: $ret\n";
  print "not ok 30\n";
}

eval{$ret +=  $inf };
eval{$ret += "$strinf"};
eval{$ret +=  $nan };
eval{$ret += "$strnan"};
eval{$ret += "61.2"};

$ret += 61.2;

if($ret == 671) {print "ok 36\n"}
else {
  warn "\n Expected 671\nGot: $ret\n";
  print "not ok 36\n";
}

eval{$ret -=  $inf };
eval{$ret -= "$strinf"};
eval{$ret -=  $nan };
eval{$ret -= "$strnan"};
eval{$ret -= "61.2"};

$ret -= 61.2;

if($ret == 610) {print "ok 42\n"}
else {
  warn "\n Expected 610\nGot: $ret\n";
  print "not ok 42\n";
}

eval{$ret /=  $inf };
eval{$ret /= "$strinf"};
eval{$ret /=  $nan };
eval{$ret /= "$strnan"};
eval{$ret /= "61.2"};

$ret /= 61.2;

if($ret == 10) {print "ok 48\n"}
else {
  warn "\n Expected 10\nGot: $ret\n";
  print "not ok 48\n";
}

if(Math::GMPz->new(10) ==  $inf ) {
  warn "\n 10 == $inf\n";
  print "not ok 49\n";
}
else {print "ok 49\n"}

if(Math::GMPz->new(10) ==  $ninf ) {
  warn "\n 10 == $ninf\n";
  print "not ok 50\n";
}
else {print "ok 50\n"}

eval{$x = (Math::GMPz->new(10) == "$strinf")};
eval{$x = (Math::GMPz->new(10) ==  $nan )};
eval{$x = (Math::GMPz->new(10) == "$strnan")};
eval{$x = (Math::GMPz->new(10) == "61.2")};

my $dec = 10.0;
if(Math::GMPz->new(10) == $dec) {print "ok 55\n"}
else {
  warn "\n ", Math::GMPz->new(10), " != $dec\n";
  print "not ok 55\n";
}

if(Math::GMPz->new(10) !=  $inf ) {print "ok 56\n"}
else {
  warn "\n 10 == $inf\n";
  print "not ok 56\n";
}

if(Math::GMPz->new(10) !=  $ninf ) {print "ok 56\n"}
else {
  warn "\n 10 == $ninf\n";
  print "not ok 56\n";
}

eval{$x = (Math::GMPz->new(10) != "$strinf")};
eval{$x = (Math::GMPz->new(10) !=  $nan )};
eval{$x = (Math::GMPz->new(10) != "$strnan")};
eval{$x = (Math::GMPz->new(10) != "61.2")};

$dec += 0.9;;
if(Math::GMPz->new(10) != $dec) {print "ok 61\n"}
else {
  warn "\n ", Math::GMPz->new(10), " == $dec\n";
  print "not ok 61\n";
}

if(Math::GMPz->new(10) <  $inf ) {print "ok 62\n"}
else {
  warn "\n 10 >= $inf\n";
  print "not ok 62\n";
}

if(Math::GMPz->new(10) <  $ninf ) {
  warn "\n10 < $ninf\n";
  print "not ok 63\n";
}
else {print "ok 63\n"}

eval{$x = (Math::GMPz->new(10) < "$strinf")};
eval{$x = (Math::GMPz->new(10) <  $nan )};
eval{$x = (Math::GMPz->new(10) < "$strnan")};
eval{$x = (Math::GMPz->new(10) < "61.2")};

$dec += 2.0;;
if(Math::GMPz->new(10) < $dec) {print "ok 68\n"}
else {
  warn "\n ", Math::GMPz->new(10), " !< $dec\n";
  print "not ok 68\n";
}

if(Math::GMPz->new(10) <=  $inf ) {print "ok 69\n"}
else {
  warn "\n 10 > $inf\n";
  print "not ok 69\n";
}

if(Math::GMPz->new(10) <=  $ninf ) {
  warn "\n10 <= $ninf\n";
  print "not ok 70\n";
}
else {print "ok 70\n"}

eval{$x = (Math::GMPz->new(10) <= "$strinf")};
eval{$x = (Math::GMPz->new(10) <=  $nan )};
eval{$x = (Math::GMPz->new(10) <= "$strnan")};
eval{$x = (Math::GMPz->new(10) <= "61.2")};

$dec -= 2.0;
if(Math::GMPz->new(10) <= $dec) {print "ok 75\n"}
else {
  warn "\n ", Math::GMPz->new(10), " > $dec\n";
  print "not ok 75\n";
}

if(Math::GMPz->new(10) >=  $inf ) {
  warn "\n 10 >= $inf\n";
  print "not ok 76\n";
}
else {print "ok 76\n"}

if(Math::GMPz->new(10) >= $ninf) {print "ok 77\n"}
else {
  warn "\n 10 < $ninf\n";
  print "not ok 77\n";
}

eval{$x = (Math::GMPz->new(10) >= "$strinf")};
eval{$x = (Math::GMPz->new(10) >=  $nan )};
eval{$x = (Math::GMPz->new(10) >= "$strnan")};
eval{$x = (Math::GMPz->new(10) >= "61.2")};

$dec -= 1.0;
if(Math::GMPz->new(10) >= $dec) {print "ok 82\n"}
else {
  warn "\n ", Math::GMPz->new(10), " < $dec\n";
  print "not ok 82\n";
}

if(Math::GMPz->new(10) >  $inf ) {
  warn "\n 10 > $inf\n";
  print "not ok 83\n";
}
else {print "ok 83\n"}

if(Math::GMPz->new(10) > $ninf) {print "ok 84\n"}
else {
  warn "\n 10 <= $ninf\n";
  print "not ok 84\n";
}

eval{$x = (Math::GMPz->new(10) > "$strinf")};
eval{$x = (Math::GMPz->new(10) >  $nan )};
eval{$x = (Math::GMPz->new(10) > "$strnan")};
eval{$x = (Math::GMPz->new(10) > "61.2")};

$dec -= 1.0;
if(Math::GMPz->new(10) > $dec) {print "ok 89\n"}
else {
  warn "\n ", Math::GMPz->new(10), " !> $dec\n";
  print "not ok 89\n";
}


