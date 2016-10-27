# Mainly want to test that:
# inf and nan are handled correctly when passed to overloaded subs (including when they're passed as strings)
# valid floating point NV's are handled correctly when passed to overloaded subs
# valid floating point values are a fatal error when passed as a string

use strict;
use warnings;
use Math::GMPz;

print "1..14\n";

my $inf = 99 ** (99 ** 99);
my $nan = $inf / $inf;
my ($ret, $x);

eval{$ret = Math::GMPz->new(10) *  $inf };
eval{$ret = Math::GMPz->new(10) * "$inf"};
eval{$ret = Math::GMPz->new(10) *  $nan };
eval{$ret = Math::GMPz->new(10) * "$nan"};
eval{$ret = Math::GMPz->new(10) * "61.2"};

if(Math::GMPz->new(10) * 61.2 == 610) {print "ok 1\n"}
else {
  warn "\n Expected 610\nGot: ", Math::GMPz->new(10) * 61.2, "\n";
  print "not ok 1\n";
}

eval{$ret = Math::GMPz->new(10) +  $inf };
eval{$ret = Math::GMPz->new(10) + "$inf"};
eval{$ret = Math::GMPz->new(10) +  $nan };
eval{$ret = Math::GMPz->new(10) + "$nan"};
eval{$ret = Math::GMPz->new(10) + "61.2"};

if(Math::GMPz->new(10) + 61.2 == 71) {print "ok 2\n"}
else {
  warn "\n Expected 71\nGot: ", Math::GMPz->new(10) + 61.2, "\n";
  print "not ok 2\n";
}

eval{$ret = Math::GMPz->new(10) /  $inf };
eval{$ret = Math::GMPz->new(10) / "$inf"};
eval{$ret = Math::GMPz->new(10) /  $nan };
eval{$ret = Math::GMPz->new(10) / "$nan"};
eval{$ret = Math::GMPz->new(10) / "61.2"};

if(Math::GMPz->new(10) / 61.2 == 0) {print "ok 3\n"}
else {
  warn "\n Expected 0\nGot: ", Math::GMPz->new(10) / 61.2, "\n";
  print "not ok 3\n";
}

eval{$ret = Math::GMPz->new(10) -  $inf };
eval{$ret = Math::GMPz->new(10) - "$inf"};
eval{$ret = Math::GMPz->new(10) -  $nan };
eval{$ret = Math::GMPz->new(10) - "$nan"};
eval{$ret = Math::GMPz->new(10) - "61.2"};

if(Math::GMPz->new(10) - 61.2 == -51) {print "ok 4\n"}
else {
  warn "\n Expected -51\nGot: ", Math::GMPz->new(10) - 61.2, "\n";
  print "not ok 4\n";
}

$ret = Math::GMPz->new(10);

eval{$ret *=  $inf };
eval{$ret *= "$inf"};
eval{$ret *=  $nan };
eval{$ret *= "$nan"};
eval{$ret *= "61.2"};

$ret *= 61.2;

if($ret == 610) {print "ok 5\n"}
else {
  warn "\n Expected 610\nGot: $ret\n";
  print "not ok 5\n";
}

eval{$ret +=  $inf };
eval{$ret += "$inf"};
eval{$ret +=  $nan };
eval{$ret += "$nan"};
eval{$ret += "61.2"};

$ret += 61.2;

if($ret == 671) {print "ok 6\n"}
else {
  warn "\n Expected 671\nGot: $ret\n";
  print "not ok 6\n";
}

eval{$ret -=  $inf };
eval{$ret -= "$inf"};
eval{$ret -=  $nan };
eval{$ret -= "$nan"};
eval{$ret -= "61.2"};

$ret -= 61.2;

if($ret == 610) {print "ok 7\n"}
else {
  warn "\n Expected 610\nGot: $ret\n";
  print "not ok 7\n";
}

eval{$ret /=  $inf };
eval{$ret /= "$inf"};
eval{$ret /=  $nan };
eval{$ret /= "$nan"};
eval{$ret /= "61.2"};

$ret /= 61.2;

if($ret == 10) {print "ok 8\n"}
else {
  warn "\n Expected 10\nGot: $ret\n";
  print "not ok 8\n";
}

eval{$x = (Math::GMPz->new(10) ==  $inf )};
eval{$x = (Math::GMPz->new(10) == "$inf")};
eval{$x = (Math::GMPz->new(10) ==  $nan )};
eval{$x = (Math::GMPz->new(10) == "$nan")};
eval{$x = (Math::GMPz->new(10) == "61.2")};

my $dec = 10.0;
if(Math::GMPz->new(10) == $dec) {print "ok 9\n"}
else {
  warn "\n ", Math::GMPz->new(10), " != $dec\n";
  print "not ok 9\n";
}

eval{$x = (Math::GMPz->new(10) !=  $inf )};
eval{$x = (Math::GMPz->new(10) != "$inf")};
eval{$x = (Math::GMPz->new(10) !=  $nan )};
eval{$x = (Math::GMPz->new(10) != "$nan")};
eval{$x = (Math::GMPz->new(10) != "61.2")};

$dec += 0.9;;
if(Math::GMPz->new(10) != $dec) {print "ok 10\n"}
else {
  warn "\n ", Math::GMPz->new(10), " == $dec\n";
  print "not ok 10\n";
}

eval{$x = (Math::GMPz->new(10) <  $inf )};
eval{$x = (Math::GMPz->new(10) < "$inf")};
eval{$x = (Math::GMPz->new(10) <  $nan )};
eval{$x = (Math::GMPz->new(10) < "$nan")};
eval{$x = (Math::GMPz->new(10) < "61.2")};

$dec += 2.0;;
if(Math::GMPz->new(10) < $dec) {print "ok 11\n"}
else {
  warn "\n ", Math::GMPz->new(11), " !< $dec\n";
  print "not ok 11\n";
}

eval{$x = (Math::GMPz->new(10) <=  $inf )};
eval{$x = (Math::GMPz->new(10) <= "$inf")};
eval{$x = (Math::GMPz->new(10) <=  $nan )};
eval{$x = (Math::GMPz->new(10) <= "$nan")};
eval{$x = (Math::GMPz->new(10) <= "61.2")};

$dec -= 2.0;
if(Math::GMPz->new(10) <= $dec) {print "ok 12\n"}
else {
  warn "\n ", Math::GMPz->new(10), " > $dec\n";
  print "not ok 12\n";
}

eval{$x = (Math::GMPz->new(10) >=  $inf )};
eval{$x = (Math::GMPz->new(10) >= "$inf")};
eval{$x = (Math::GMPz->new(10) >=  $nan )};
eval{$x = (Math::GMPz->new(10) >= "$nan")};
eval{$x = (Math::GMPz->new(10) >= "61.2")};

$dec -= 1.0;
if(Math::GMPz->new(10) >= $dec) {print "ok 13\n"}
else {
  warn "\n ", Math::GMPz->new(10), " < $dec\n";
  print "not ok 13\n";
}

eval{$x = (Math::GMPz->new(10) >  $inf )};
eval{$x = (Math::GMPz->new(10) > "$inf")};
eval{$x = (Math::GMPz->new(10) >  $nan )};
eval{$x = (Math::GMPz->new(10) > "$nan")};
eval{$x = (Math::GMPz->new(10) > "61.2")};

$dec -= 1.0;
if(Math::GMPz->new(10) > $dec) {print "ok 14\n"}
else {
  warn "\n ", Math::GMPz->new(10), " !> $dec\n";
  print "not ok 14\n";
}


