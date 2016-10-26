# Mainly want to test that:
# inf and nan are handled correctly when passed to overloaded subs (including when they're passed as strings)
# valid floating point NV's are handled correctly when passed to overloaded subs
# valid floating point values are a fatal error when passed as a string

use strict;
use warnings;
use Math::GMPz;

print "1..1\n";

my $inf = 99 ** (99 ** 99);
my $nan = $inf / $inf;
my $ret;

eval{$ret = Math::GMPz->new(10) *  $inf };
eval{$ret = Math::GMPz->new(10) * "$inf"};
eval{$ret = Math::GMPz->new(10) *  $nan };
eval{$ret = Math::GMPz->new(10) * "$nan"};
eval{$ret = Math::GMPz->new(10) * "61.2"};

if(Math::GMPz->new(10) * 61.2 == 610) {print "ok 1\n"}
else {
  warn "\n1: Expected 610\nGot: ", Math::GMPz->new(10) * 61.2, "\n";
  print "not ok 1\n";
}

eval{$ret = Math::GMPz->new(10) +  $inf };
eval{$ret = Math::GMPz->new(10) + "$inf"};
eval{$ret = Math::GMPz->new(10) +  $nan };
eval{$ret = Math::GMPz->new(10) + "$nan"};
eval{$ret = Math::GMPz->new(10) + "61.2"};

if(Math::GMPz->new(10) + 61.2 == 71) {print "ok 2\n"}
else {
  warn "\n2: Expected 71\nGot: ", Math::GMPz->new(10) + 61.2, "\n";
  print "not ok 2\n";
}

eval{$ret = Math::GMPz->new(10) /  $inf };
eval{$ret = Math::GMPz->new(10) / "$inf"};
eval{$ret = Math::GMPz->new(10) /  $nan };
eval{$ret = Math::GMPz->new(10) / "$nan"};
eval{$ret = Math::GMPz->new(10) / "61.2"};

if(Math::GMPz->new(10) / 61.2 == 0) {print "ok 3\n"}
else {
  warn "\n3: Expected 0\nGot: ", Math::GMPz->new(10) / 61.2, "\n";
  print "not ok 3\n";
}

eval{$ret = Math::GMPz->new(10) -  $inf };
eval{$ret = Math::GMPz->new(10) - "$inf"};
eval{$ret = Math::GMPz->new(10) -  $nan };
eval{$ret = Math::GMPz->new(10) - "$nan"};
eval{$ret = Math::GMPz->new(10) - "61.2"};

if(Math::GMPz->new(10) - 61.2 == -51) {print "ok 4\n"}
else {
  warn "\n4: Expected -51\nGot: ", Math::GMPz->new(10) - 61.2, "\n";
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
  warn "\n5: Expected 610\nGot: $ret\n";
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
  warn "\n6: Expected 671\nGot: $ret\n";
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
  warn "\n7: Expected 610\nGot: $ret\n";
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
  warn "\n8: Expected 10\nGot: $ret\n";
  print "not ok 8\n";
}



