use ExtUtils::MakeMaker;
use Config;
require 5.006;

$| = 1;

our %args = map { split /\s*=\s*/ } @ARGV;
our $LIBS = $args{ LIBS } || "-lgmp";
our $INC = $args{ INC };

print "\nThis module requires gmp-4.2.0 (or later)\n\n";

$use_64_bit_int = 0; # Let perl decide whether to include 64-bit 'long long' support
$use_long_double = 0;# Let perl decide whether to include 'long double' support

#$use_64_bit_int = -1; # Force exclusion of 64-bit 'long long' support
#$use_long_double = -1;# Force exclusion of 'long double' support

#$use_64_bit_int = 1; # Force inclusion of 64-bit 'long long' support
#$use_long_double = 1;# Force inclusion of 'long double' support

my $defines = $] < 5.008 ? "-DOLDPERL" : "-DNEWPERL";

if($use_64_bit_int == -1) {}
elsif($use_64_bit_int == 1) {$defines .= " -DUSE_64_BIT_INT"}
else {
  unless($Config::Config{ivsize} < 8) {
    $defines .= " -DUSE_64_BIT_INT";
  }
}

if($use_long_double == -1) {}
elsif($use_long_double == 1) {$defines .= " -DUSE_LONG_DOUBLE"}
else {
  if($Config::Config{nvsize} > 8 ) {
    $defines .= " -DUSE_LONG_DOUBLE";
  }
}

$defines =~ /-DUSE_64_BIT_INT/ ? print "Building with 64-bit'long long' support\n" :
                                 print "Building without 64-bit 'long long' support\n";

print "If this is wrong, see the \"64-bit support\" section in the README\n\n";

$defines =~ /-DUSE_LONG_DOUBLE/ ? print "Building with 'long double' support\n" :
                                 print "Building without 'long double' support\n";

print "If this is wrong, see the \"64-bit support\" section in the README\n\n";

my %options = (
  NAME => 'Math::GMPz',
  AUTHOR => 'Sisyphus (sisyphus at (@) cpan dot (.) org)',
  ABSTRACT => 'Perl interface to the GMP integer functions',
  DEFINE   => $defines,
  LIBS => [
    '-lgmp'
  ],
  LICENSE  => 'perl',
  VERSION_FROM => 'GMPz.pm',
  clean   => { FILES => 'out1.txt out2.txt out3.txt out4.txt out5.txt out6.txt out7.txt' },
  META_MERGE => {
   'meta-spec' => { version => 2 },
    resources => {
      repository => {
        type => 'git',
        url => 'https://github.com/sisyphus/math-gmpz.git',
        web => 'https://github.com/sisyphus/math-gmpz',
      },
    },
  },
);
WriteMakefile(%options);

# Remove the Makefile dependency. Causes problems on a few systems.
sub MY::makefile { '' }

