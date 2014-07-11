    package Math::GMPz;
    use strict;
    use Math::GMPz::Random;
    require Exporter;
    *import = \&Exporter::import;
    require DynaLoader;

    use constant _UOK_T         => 1;
    use constant _IOK_T         => 2;
    use constant _NOK_T         => 3;
    use constant _POK_T         => 4;
    use constant _MATH_MPFR_T   => 5;
    use constant _MATH_GMPf_T   => 6;
    use constant _MATH_GMPq_T   => 7;
    use constant _MATH_GMPz_T   => 8;
    use constant _MATH_GMP_T    => 9;
    use constant _MATH_MPC_T    => 10;

use subs qw( __GNU_MP_VERSION __GNU_MP_VERSION_MINOR __GNU_MP_VERSION_PATCHLEVEL
             __GNU_MP_RELEASE __GMP_CC __GMP_CFLAGS);

use overload
    '+'    => \&overload_add,
    '-'    => \&overload_sub,
    '*'    => \&overload_mul,
    '/'    => \&overload_div,
    '+='   => \&overload_add_eq,
    '-='   => \&overload_sub_eq,
    '*='   => \&overload_mul_eq,
    '/='   => \&overload_div_eq,
    '%'    => \&overload_mod,
    '%='   => \&overload_mod_eq,
    '<<'   => \&overload_lshift,
    '<<='  => \&overload_lshift_eq,
    '>>'   => \&overload_rshift,
    '>>='  => \&overload_rshift_eq,
    '&'    => \&overload_and,
    '&='   => \&overload_and_eq,
    '|'    => \&overload_ior,
    '|='   => \&overload_ior_eq,
    '^'    => \&overload_xor,
    '^='   => \&overload_xor_eq,
    '~'    => \&overload_com,
    '**'   => \&overload_pow,
    '**='  => \&overload_pow_eq,
    'sqrt' => \&overload_sqrt,
    '""'   => \&overload_string,
    '++'   => \&overload_inc,
    '--'   => \&overload_dec,
    '>'    => \&overload_gt,
    '>='   => \&overload_gte,
    '<'    => \&overload_lt,
    '<='   => \&overload_lte,
    '<=>'  => \&overload_spaceship,
    '=='   => \&overload_equiv,
    '!='   => \&overload_not_equiv,
    '!'    => \&overload_not,
    '='    => \&overload_copy,
    'abs'  => \&overload_abs;

    @Math::GMPz::EXPORT_OK = qw(
__GNU_MP_VERSION __GNU_MP_VERSION_MINOR __GNU_MP_VERSION_PATCHLEVEL
__GNU_MP_RELEASE __GMP_CC __GMP_CFLAGS
Rmpz_abs Rmpz_add Rmpz_add_ui Rmpz_addmul Rmpz_addmul_ui Rmpz_and Rmpz_bin_ui
Rmpz_bin_uiui Rmpz_bin_si Rmpz_cdiv_q Rmpz_cdiv_q_2exp Rmpz_cdiv_q_ui Rmpz_cdiv_qr
Rmpz_cdiv_qr_ui Rmpz_cdiv_r Rmpz_cdiv_r_2exp Rmpz_cdiv_r_ui Rmpz_cdiv_ui
Rmpz_clear Rmpz_clrbit Rmpz_cmp Rmpz_cmp_d Rmpz_cmp_si Rmpz_cmp_ui Rmpz_cmpabs
Rmpz_cmpabs_d Rmpz_cmpabs_ui Rmpz_com Rmpz_combit Rmpz_congruent_2exp_p
Rmpz_congruent_p Rmpz_congruent_ui_p Rmpz_div Rmpz_divmod Rmpz_div_ui
Rmpz_divmod_ui Rmpz_div_2exp Rmpz_mod_2exp Rmpz_divexact Rmpz_divexact_ui
Rmpz_divisible_2exp_p Rmpz_divisible_p Rmpz_divisible_ui_p Rmpz_even_p
Rmpz_export Rmpz_fac_ui Rmpz_2fac_ui Rmpz_mfac_uiui Rmpz_primorial_ui
Rmpz_fdiv_q Rmpz_fdiv_q_2exp Rmpz_fdiv_q_ui
Rmpz_fdiv_qr Rmpz_fdiv_qr_ui Rmpz_fdiv_r Rmpz_fdiv_r_2exp Rmpz_fdiv_r_ui
Rmpz_fdiv_ui Rmpz_fib2_ui Rmpz_fib_ui Rmpz_fits_sint_p Rmpz_fits_slong_p
Rmpz_fits_sshort_p Rmpz_fits_uint_p Rmpz_fits_ulong_p Rmpz_fits_ushort_p
Rmpz_fprintf Rmpz_sprintf Rmpz_snprintf
Rmpz_gcd Rmpz_gcd_ui Rmpz_gcdext Rmpz_get_d_2exp Rmpz_get_si Rmpz_get_str
Rmpz_get_ui Rmpz_getlimbn Rmpz_hamdist Rmpz_import Rmpz_init Rmpz_init2
Rmpz_init2_nobless Rmpz_init_nobless Rmpz_init_set Rmpz_init_set_d
Rmpz_init_set_d_nobless Rmpz_init_set_nobless Rmpz_init_set_si
Rmpz_init_set_si_nobless Rmpz_init_set_str Rmpz_init_set_str_nobless
Rmpz_init_set_ui Rmpz_init_set_ui_nobless Rmpz_inp_str Rmpz_inp_raw
Rmpz_invert Rmpz_ior
Rmpz_jacobi Rmpz_kronecker Rmpz_kronecker_si Rmpz_kronecker_ui Rmpz_lcm
Rmpz_lcm_ui Rmpz_legendre Rmpz_lucnum2_ui Rmpz_lucnum_ui Rmpz_mod Rmpz_mod_ui
Rmpz_mul Rmpz_mul_2exp Rmpz_mul_si Rmpz_mul_ui Rmpz_neg Rmpz_nextprime
Rmpz_odd_p Rmpz_out_str Rmpz_out_raw
Rmpz_perfect_power_p Rmpz_perfect_square_p
Rmpz_popcount Rmpz_pow_ui Rmpz_powm Rmpz_powm_sec Rmpz_powm_ui Rmpz_printf
Rmpz_probab_prime_p Rmpz_realloc2 Rmpz_remove Rmpz_root Rmpz_rootrem
Rmpz_rrandomb Rmpz_scan0 Rmpz_scan1 Rmpz_set Rmpz_set_d Rmpz_set_f Rmpz_set_q
Rmpz_set_si Rmpz_set_str Rmpz_set_ui Rmpz_setbit Rmpz_sgn Rmpz_si_kronecker
Rmpz_size Rmpz_sizeinbase Rmpz_sqrt Rmpz_sqrtrem Rmpz_sub Rmpz_sub_ui
Rmpz_submul Rmpz_submul_ui Rmpz_swap Rmpz_tdiv_q Rmpz_tdiv_q_2exp
Rmpz_tdiv_q_ui Rmpz_tdiv_qr Rmpz_tdiv_qr_ui Rmpz_tdiv_r Rmpz_tdiv_r_2exp
Rmpz_tdiv_r_ui Rmpz_tdiv_ui Rmpz_tstbit Rmpz_ui_kronecker Rmpz_ui_pow_ui
Rmpz_ui_sub Rmpz_urandomb Rmpz_urandomm Rmpz_xor
rand_init rand_clear
TRmpz_out_str TRmpz_inp_str
zgmp_randseed zgmp_randseed_ui zgmp_randclear
zgmp_randinit_default zgmp_randinit_mt zgmp_randinit_lc_2exp zgmp_randinit_lc_2exp_size
zgmp_randinit_set zgmp_randinit_default_nobless zgmp_randinit_mt_nobless
zgmp_randinit_lc_2exp_nobless zgmp_randinit_lc_2exp_size_nobless zgmp_randinit_set_nobless
zgmp_urandomb_ui zgmp_urandomm_ui
    );
    our $VERSION = '0.39';
    #$VERSION = eval $VERSION;

    DynaLoader::bootstrap Math::GMPz $VERSION;

    $Math::GMPz::NULL = _Rmpz_NULL();

    %Math::GMPz::EXPORT_TAGS =(mpz => [qw(
Rmpz_abs Rmpz_add Rmpz_add_ui Rmpz_addmul Rmpz_addmul_ui Rmpz_and Rmpz_bin_ui
Rmpz_bin_uiui Rmpz_bin_si Rmpz_cdiv_q Rmpz_cdiv_q_2exp Rmpz_cdiv_q_ui Rmpz_cdiv_qr
Rmpz_cdiv_qr_ui Rmpz_cdiv_r Rmpz_cdiv_r_2exp Rmpz_cdiv_r_ui Rmpz_cdiv_ui
Rmpz_clear Rmpz_clrbit Rmpz_cmp Rmpz_cmp_d Rmpz_cmp_si Rmpz_cmp_ui Rmpz_cmpabs
Rmpz_cmpabs_d Rmpz_cmpabs_ui Rmpz_com Rmpz_combit Rmpz_congruent_2exp_p
Rmpz_congruent_p Rmpz_congruent_ui_p Rmpz_div Rmpz_divmod Rmpz_div_ui
Rmpz_divmod_ui Rmpz_div_2exp Rmpz_mod_2exp Rmpz_divexact Rmpz_divexact_ui
Rmpz_divisible_2exp_p Rmpz_divisible_p Rmpz_divisible_ui_p Rmpz_even_p
Rmpz_export Rmpz_fac_ui Rmpz_2fac_ui Rmpz_mfac_uiui Rmpz_primorial_ui
Rmpz_fdiv_q Rmpz_fdiv_q_2exp Rmpz_fdiv_q_ui
Rmpz_fdiv_qr Rmpz_fdiv_qr_ui Rmpz_fdiv_r Rmpz_fdiv_r_2exp Rmpz_fdiv_r_ui
Rmpz_fdiv_ui Rmpz_fib2_ui Rmpz_fib_ui Rmpz_fits_sint_p Rmpz_fits_slong_p
Rmpz_fits_sshort_p Rmpz_fits_uint_p Rmpz_fits_ulong_p Rmpz_fits_ushort_p
Rmpz_fprintf Rmpz_sprintf Rmpz_snprintf
Rmpz_gcd Rmpz_gcd_ui Rmpz_gcdext Rmpz_get_d_2exp Rmpz_get_si Rmpz_get_str
Rmpz_get_ui Rmpz_getlimbn Rmpz_hamdist Rmpz_import Rmpz_init Rmpz_init2
Rmpz_init2_nobless Rmpz_init_nobless Rmpz_init_set Rmpz_init_set_d
Rmpz_init_set_d_nobless Rmpz_init_set_nobless Rmpz_init_set_si
Rmpz_init_set_si_nobless Rmpz_init_set_str Rmpz_init_set_str_nobless
Rmpz_init_set_ui Rmpz_init_set_ui_nobless Rmpz_inp_str Rmpz_inp_raw
Rmpz_invert Rmpz_ior
Rmpz_jacobi Rmpz_kronecker Rmpz_kronecker_si Rmpz_kronecker_ui Rmpz_lcm
Rmpz_lcm_ui Rmpz_legendre Rmpz_lucnum2_ui Rmpz_lucnum_ui Rmpz_mod Rmpz_mod_ui
Rmpz_mul Rmpz_mul_2exp Rmpz_mul_si Rmpz_mul_ui Rmpz_neg Rmpz_nextprime
Rmpz_odd_p Rmpz_out_str Rmpz_out_raw
Rmpz_perfect_power_p Rmpz_perfect_square_p
Rmpz_popcount Rmpz_pow_ui Rmpz_powm Rmpz_powm_sec Rmpz_powm_ui Rmpz_printf
Rmpz_probab_prime_p Rmpz_realloc2 Rmpz_remove Rmpz_root Rmpz_rootrem
Rmpz_rrandomb Rmpz_scan0 Rmpz_scan1 Rmpz_set Rmpz_set_d Rmpz_set_f Rmpz_set_q
Rmpz_set_si Rmpz_set_str Rmpz_set_ui Rmpz_setbit Rmpz_sgn Rmpz_si_kronecker
Rmpz_size Rmpz_sizeinbase Rmpz_sqrt Rmpz_sqrtrem Rmpz_sub Rmpz_sub_ui
Rmpz_submul Rmpz_submul_ui Rmpz_swap Rmpz_tdiv_q Rmpz_tdiv_q_2exp
Rmpz_tdiv_q_ui Rmpz_tdiv_qr Rmpz_tdiv_qr_ui Rmpz_tdiv_r Rmpz_tdiv_r_2exp
Rmpz_tdiv_r_ui Rmpz_tdiv_ui Rmpz_tstbit Rmpz_ui_kronecker Rmpz_ui_pow_ui
Rmpz_ui_sub Rmpz_urandomb Rmpz_urandomm Rmpz_xor
rand_init rand_clear
TRmpz_out_str TRmpz_inp_str
zgmp_randseed zgmp_randseed_ui zgmp_randclear
zgmp_randinit_default zgmp_randinit_mt zgmp_randinit_lc_2exp zgmp_randinit_lc_2exp_size
zgmp_randinit_set zgmp_randinit_default_nobless zgmp_randinit_mt_nobless
zgmp_randinit_lc_2exp_nobless zgmp_randinit_lc_2exp_size_nobless zgmp_randinit_set_nobless
zgmp_urandomb_ui zgmp_urandomm_ui )]
);

sub dl_load_flags {0} # Prevent DynaLoader from complaining and croaking

sub new {

    # This function caters for 2 possibilities:
    # 1) that 'new' has been called OOP style - in which
    #    case there will be a maximum of 3 args
    # 2) that 'new' has been called as a function - in
    #    which case there will be a maximum of 2 args.
    # If there are no args, then we just want to return an
    # initialized Math::GMPz
    if(!@_) {return Rmpz_init()}

    if(@_ > 3) {die "Too many arguments supplied to new()"}

    # If 'new' has been called OOP style, the first arg is the string
    # "Math::GMPz" which we don't need - so let's remove it. However,
    # if the first arg is a Math::GMPz object (which is a possibility),
    # then we'll get a fatal error when we check it for equivalence to
    # the string "Math::GMPz". So we first need to check that it's not
    # an object - which we'll do by using the ref() function:
    if(!ref($_[0]) && $_[0] eq "Math::GMPz") {
      shift;
      if(!@_) {return Rmpz_init()}
      }

    # @_ can now contain a maximum of 2 args - the value, and iff the value is
    # a string, (optionally) the base of the numeric string.
    if(@_ > 2) {die "Too many arguments supplied to new() - expected no more than two"}

    my ($arg1, $type, $base);

    # $_[0] is the value, $_[1] (if supplied) is the base of the number
    # in the string $[_0].
    $arg1 = shift;
    $base = 0;

    $type = _itsa($arg1);
    if(!$type) {die "Inappropriate argument supplied to new()"}

    # Create a Math::GMPz object that has $arg1 as its value.
    # Die if there are any additional args (unless $type == _POK_T)
    if($type == _UOK_T || $type == _IOK_T) {
      if(@_ ) {die "Too many arguments supplied to new() - expected only one"}
      return Rmpz_init_set_str($arg1, 10);
    }

    if($type == _NOK_T) {
      if(@_ ) {die "Too many arguments supplied to new() - expected only one"}
      if(Math::GMPz::_has_longdouble()) {
        return _Rmpz_init_set_ld($arg1);
        }
      return Rmpz_init_set_d($arg1);

    }

    if($type == _POK_T) { # POK
      if(@_ > 1) {die "Too many arguments supplied to new() - expected no more than two"}
      $base = shift if @_;
      if($base < 0 || $base == 1 || $base > 62) {die "Invalid value for base"}
      return Rmpz_init_set_str($arg1, $base);
    }

    if($type == _MATH_GMPz_T || $type == _MATH_GMP_T) { # Math::GMPz or Math::GMP object
      if(@_) {die "Too many arguments supplied to new() - expected only one"}
      return Rmpz_init_set($arg1);
    }
}

sub Rmpz_out_str {
    if(@_ == 2) {
       die "Inappropriate 1st arg supplied to Rmpz_out_str" if _itsa($_[0]) != _MATH_GMPz_T && _itsa($_[0]) != _MATH_GMP_T;
       return _Rmpz_out_str($_[0], $_[1]);
    }
    if(@_ == 3) {
      if(_itsa($_[0]) == _MATH_GMPz_T || _itsa($_[0]) == _MATH_GMP_T) {return _Rmpz_out_strS($_[0], $_[1], $_[2])}
      die "Incorrect args supplied to Rmpz_out_str" if _itsa($_[1]) != _MATH_GMPz_T && _itsa($_[1]) != _MATH_GMP_T;
      return _Rmpz_out_strP($_[0], $_[1], $_[2]);
    }
    if(@_ == 4) {
      die "Inappropriate 2nd arg supplied to Rmpz_out_str" if _itsa($_[1]) != _MATH_GMPz_T && _itsa($_[1]) != _MATH_GMP_T;
      return _Rmpz_out_strPS($_[0], $_[1], $_[2], $_[3]);
    }
    die "Wrong number of arguments supplied to Rmpz_out_str()";
}

sub TRmpz_out_str {
    if(@_ == 3) {
      die "Inappropriate 3rd arg supplied to TRmpz_out_str" if _itsa($_[2]) != _MATH_GMPz_T && _itsa($_[2]) != _MATH_GMP_T;
      return _TRmpz_out_str($_[0], $_[1], $_[2]);
    }
    if(@_ == 4) {
      if(_itsa($_[2]) == _MATH_GMPz_T || _itsa($_[2]) == _MATH_GMP_T) {return _TRmpz_out_strS($_[0], $_[1], $_[2], $_[3])}
      die "Incorrect args supplied to TRmpz_out_str" if _itsa($_[3]) != _MATH_GMPz_T && _itsa($_[3]) != _MATH_GMP_T;
      return _TRmpz_out_strP($_[0], $_[1], $_[2], $_[3]);
    }
    if(@_ == 5) {
      die "Inappropriate 4th arg supplied to TRmpz_out_str" if _itsa($_[3]) != _MATH_GMPz_T && _itsa($_[3]) != _MATH_GMP_T;
      return _TRmpz_out_strPS($_[0], $_[1], $_[2], $_[3], $_[4]);
    }
    die "Wrong number of arguments supplied to TRmpz_out_str()";
}

sub Rpi_x {
  Rmpz_set_ui($_[0], 1);
  Rmpz_mul_2exp($_[0], $_[0], $_[1]);
  Rmpz_tdiv_q_ui($_[0], $_[0], int(0.693147180559945 * $_[1]));
  }

sub prime_ratio {
    return int($_[0] * 0.3465735902799726);
    }

sub Rprovable_small {
     my $lim = 341550071728321;
     my $last = 0;
     if(Rmpz_cmp_ui($_[0], 2) < 0 || Rmpz_cmp_d($_[0], $lim) >= 0)
       {die "Argument to provable_small (= ", Rmpz_get_str($_[0], 10), " must be in range [2..341550071728321]"}
     if(Rmpz_cmp_ui($_[0], 18) < 0) {
       if(Rmpz_cmp_ui($_[0], 2) <= 0) {Rmpz_set_ui($_[0], 2)}
       if(!Rmpz_cmp_ui($_[0], 3)) {Rmpz_set_ui($_[0], 3)}
       if(Rmpz_cmp_ui($_[0], 5) <= 0) {Rmpz_set_ui($_[0], 5)}
       if(Rmpz_cmp_ui($_[0], 7) <= 0) {Rmpz_set_ui($_[0], 7)}
       if(Rmpz_cmp_ui($_[0], 11) <= 0) {Rmpz_set_ui($_[0], 11)}
       if(Rmpz_cmp_ui($_[0], 13) <= 0) {Rmpz_set_ui($_[0], 13)}
       Rmpz_set_ui($_[0], 17);
       }

     else {
       if(!Rmpz_tstbit($_[0], 0)) {Rmpz_add_ui($_[0], $_[0], 1)};
       while(Rmpz_cmp_d($_[0], $lim) < 0) {
            if(Rrm_gmp($_[0], 2) && Rrm_gmp($_[0], 3) && Rrm_gmp($_[0], 5) && Rrm_gmp($_[0], 7)
               && Rrm_gmp($_[0], 11) && Rrm_gmp($_[0], 13) && Rrm_gmp($_[0], 17))
               {$last = 1;
                last;
               }
            Rmpz_add_ui($_[0], $_[0], 2);
            }
       if(!$last) {Rmpz_set_ui($_[0], 0)}
       }

     }

sub Rprime_test {
    my $ul = $_[1] + 1;
    for(2..$ul) {
       if(!Rrm_gmp($_[0], $_)) {return 0}
       }
    return 1;
    }

sub Rnext_germaine_prime {
    my $last = 0;
    my @range = Rsieve_gmp($_[4], $_[5], $_[2]);
    Rmpz_set($_[0], $_[2]);
    my $sub = 0;
    my $mod;
    for(@range) {
        Rmpz_add_ui($_[0], $_[0], $_ - $sub);
        $sub = $_;
        $mod = Rmpz_tdiv_ui($_[0], 3);
        if($mod == 2) {
           if(Rprime_test($_[0], $_[3])) {
              Rmpz_mul_2exp($_[1], $_[0], 1);
              Rmpz_add_ui($_[1], $_[1], 1);
              if(Rprime_test($_[1], $_[3])) {
                 $last = 1;
                 last;
                 }
              }
           }
         }
    if(!$last) {
       Rmpz_set_ui($_[0], 0);
       Rmpz_set_ui($_[1], 0);
       }
    }

sub merten {
    my $gamma = 0.57721566490153286; # Euler's constant
    return 1 / exp($gamma) / log($_[0]);
    }

sub Rgenerator_zp {
    my $s = Rmpz_sizeinbase($_[1], 2);
    my $order = Rmpz_init2($s);
    my $temp = Rmpz_init2($s);
    my $check = Rmpz_init2($s);
    Rmpz_set($order, $_[1]);
    Rmpz_sub_ui($order, $order, 1);
    Rmpz_set($check, $order);

    my $nok = (1,0);
    for(@{$_[2]}) {
       if(!Rmpz_divisible_ui_p($order, $_)) {$nok = 1}
       Rmpz_set_ui($temp, $_);
       Rmpz_remove($check, $check, $temp);
       }

    if($nok) {die "Incorrect factors supplied to 3rd argument to Rgenerator_zp() function"}

    if(defined($_[3])) {
       $nok = 0;
       for(@{$_[3]}) {
          if(!Rmpz_divisible_p($order, $_)) {$nok = 1}
          Rmpz_remove($check, $check, $_);
          }
     if($nok) {die "Incorrect factors supplied to 4th argument to Rgenerator_zp function"}
       }

     if(Rmpz_cmp_ui($check, 1)) {die "Incomplete factorisation supplied to Rgenerator_zp function"};

    while(1) {
         my $flag = 1;
         if(Rmpz_cmp($_[0], $order) > 0){warn "Generator greater than order. Re-setting generator %= order and continuing....";
            Rmpz_tdiv_r($_[0], $_[0], $order);
            }
         for(@{$_[2]}) {
            Rmpz_divexact_ui($temp, $order, $_);
            Rmpz_powm($check, $_[0], $temp, $_[1]);
            if(!Rmpz_cmp_ui($check, 1)) {
              $flag = 0;
              last;
              }
            }

          if($flag && defined($_[3])) {
            for(@{$_[3]}) {
               Rmpz_divexact($temp, $order, $_);
               Rmpz_powm($check, $_[0], $temp, $_[1]);
               if(!Rmpz_cmp_ui($check, 1)) {
                 $flag = 0;
                 last;
                 }
               }
            }

         if($flag) {last}
         Rmpz_add_ui($_[0], $_[0], 1);
         }

}

sub Rnext_proven {
    my $s = Rmpz_sizeinbase($_[1], 2);
    my $r = Rmpz_init2($s);
    my $c = Rmpz_init2($s);
    my $two = Rmpz_init_set_ui(2);

    if(!defined($_[5])) {
       Rmpz_set($r, $_[1]);
       Rmpz_sub_ui($r, $r, 1);
       }
    else {Rmpz_set($r, $_[5])}

    while(1) {
         if($_[2]) {print STDERR "."}
         if(Rmpz_cmp_si($r, 1) < 0) {die "Failed to find next prime in Rnext_proven function"}
         Rmpz_mul_2exp($_[0], $r, 1);
         Rmpz_mul($_[0], $_[1], $_[0]);
         Rmpz_add_ui($_[0], $_[0], 1);
         if(Math::GMPz::trial_div_ul($_[0], $_[4]) == 1) {
           Rmpz_set($c, $_[0]);
           Rmpz_sub_ui($c, $c, 1);
           Rmpz_powm($c, $two, $c, $_[0]);
           if(!Rmpz_cmp_ui($c, 1)) {
             if($_[2]) {print STDERR "*"}
             Rmpz_mul_2exp($c, $r, 1);
             Rmpz_powm($c, $two, $c, $_[0]);
             Rmpz_sub_ui($c, $c, 1);
             Rmpz_gcd($c, $c, $_[0]);
             if(!Rmpz_cmp_ui($c, 1)) {last}
             }
           }
         Rmpz_sub_ui($r, $r, 1);
         }

    if($_[3]) {
      if(!Rmpz_probab_prime_p($_[0], 10)) {die "Rnext_proven returned a composite"}
      }


    if($_[2]) {print STDERR Rmpz_sizeinbase($_[0], 2), "\n"}

}

sub _rewrite {
    my $len = length($_[0]);
    my @split = ();
    my @ret = ();
    for(my $i = 0; $i < $len - 1; $i++) {
       if(substr($_[0], $i, 1) eq '%') {
         if(substr($_[0], $i + 1, 1) eq '%') { $i++ }
         else { push(@split, $i) }
         }
       }

    push(@split, $len);
    shift(@split);

    my $start = 0;

    for(@split) {
       push(@ret, substr($_[0], $start, $_ - $start));
       $start = $_;
       }

    return @ret;
}

sub Rmpz_printf {
    local $| = 1;
    push @_, 0 if @_ == 1; # add a dummy second argument
    die "Rmpz_printf must pass 2 arguments: format string, and variable" if @_ != 2;
    wrap_gmp_printf(@_);
}

sub Rmpz_fprintf {
    push @_, 0 if @_ == 2; # add a dummy third argument
    die "Rmpz_fprintf must pass 3 arguments: filehandle, format string, and variable" if @_ != 3;
    wrap_gmp_fprintf(@_);
}

sub Rmpz_sprintf {

    my $len;

    if(@_ == 3) {      # optional arg wasn't provided
      $len = wrap_gmp_sprintf($_[0], $_[1], 0, $_[2]);  # Set missing arg to 0
    }
    else {
      die "Rmpz_sprintf must pass 4 arguments: buffer, format string, variable, buflen" if @_ != 4;
      $len = wrap_gmp_sprintf(@_);
    }

    return $len;
}

sub Rmpz_snprintf {

    my $len;

    if(@_ == 4) {      # optional arg wasn't provided
      $len = wrap_gmp_sprintf($_[0], $_[1], $_[2], 0, $_[3]);  # Set missing arg to 0
    }
    else {
      die "Rmpz_snprintf must pass 5 arguments: buffer, bytes written, format string, variable and buflen" if @_ != 5;
      $len = wrap_gmp_snprintf(@_);
    }

    return $len;
}

sub __GNU_MP_VERSION {return ___GNU_MP_VERSION()}
sub __GNU_MP_VERSION_MINOR {return ___GNU_MP_VERSION_MINOR()}
sub __GNU_MP_VERSION_PATCHLEVEL {return ___GNU_MP_VERSION_PATCHLEVEL()}
sub __GNU_MP_RELEASE {return ___GNU_MP_RELEASE()}
sub __GMP_CC {return ___GMP_CC()}
sub __GMP_CFLAGS {return ___GMP_CFLAGS()}

*zgmp_randseed =                      \&Math::GMPz::Random::Rgmp_randseed;
*zgmp_randseed_ui =                   \&Math::GMPz::Random::Rgmp_randseed_ui;
*zgmp_randclear =                     \&Math::GMPz::Random::Rgmp_randclear;
*zgmp_randinit_default =              \&Math::GMPz::Random::Rgmp_randinit_default;
*zgmp_randinit_mt =                   \&Math::GMPz::Random::Rgmp_randinit_mt;
*zgmp_randinit_lc_2exp =              \&Math::GMPz::Random::Rgmp_randinit_lc_2exp;
*zgmp_randinit_lc_2exp_size =         \&Math::GMPz::Random::Rgmp_randinit_lc_2exp_size;
*zgmp_randinit_set =                  \&Math::GMPz::Random::Rgmp_randinit_set;
*zgmp_randinit_default_nobless =      \&Math::GMPz::Random::Rgmp_randinit_default_nobless;
*zgmp_randinit_mt_nobless =           \&Math::GMPz::Random::Rgmp_randinit_mt_nobless;
*zgmp_randinit_lc_2exp_nobless =      \&Math::GMPz::Random::Rgmp_randinit_lc_2exp_nobless;
*zgmp_randinit_lc_2exp_size_nobless = \&Math::GMPz::Random::Rgmp_randinit_lc_2exp_size_nobless;
*zgmp_randinit_set_nobless =          \&Math::GMPz::Random::Rgmp_randinit_set_nobless;
*zgmp_urandomb_ui =                   \&Math::GMPz::Random::Rgmp_urandomb_ui;
*zgmp_urandomm_ui =                   \&Math::GMPz::Random::Rgmp_urandomm_ui;

1;

__END__

=head1 NAME

   Math::GMPz - perl interface to the GMP library's integer (mpz) functions.

=head1 DEPENDENCIES

   This module needs the GMP C library - available from:
   http://gmplib.org

=head1 DESCRIPTION

   A bignum module utilising the Gnu MP (GMP) library.
   Basically this module simply wraps nearly all of
   the integer functions provided by that library.
   The documentation below extensively plagiarises
   the documentation at http://gmplib.org.
   See the Math::GMPz test suite for examples of
   usage.

=head1 SYNOPSIS

   use Math::GMPz qw(:mpz :primes :supp);

   my $string = 'fa9eeeeeeeeeeeeea1234dcbaef1';
   my $base = 16;

   # Create the Math::GMPz object
   my $bn1 = Rmpz_init_set_str($string, $base);

   # Create another Math::GMPz object that holds
   # an initial value of zero, but has enough
   # memory allocated to store a 131-bit number.
   # If 131 bits turns out to be insufficient, it
   # doesn't matter - additional memory is allocated
   # automatically to Math::GMPz objects as needed
   # by the GMP library.
   my $bn2 = Rmpz_init2(131);

   # Create another Math::GMPz object initialised to 0.
   my $bn3 = Rmpz_init();

   # or use the new() function:
   my $bn4 = Math::GMPz->new(12345);

   # Perform some operations ... see 'FUNCTIONS' below.

   .
   .

   # print out the value held by $bn1 (in octal):
   print Rmpz_get_str($bn1, 8), "\n";

   # print out the value held by $bn1 (in decimal):
   print Rmpz_get_str($bn1, 10);

   # print out the value held by $bn1 (in base 29)
   # using the (alternative) Rmpz_out_str()
   # function. (This function doesn't print a newline.)
   Rmpz_out_str($bn1, 29);

=head1 MEMORY MANAGEMENT

   Objects created with the Rmpz_init* functions have
   been blessed into package Math::GMPz. They will
   therefore be automatically cleaned up by the DESTROY()
   function whenever they go out of scope.

   For each Rmpz_init* function there is a corresponding function
   called Rmpz_init*_nobless which returns an
   unblessed object. If you create Math::GMPz objects
   using the '_nobless' versions, it will then be up to you
   to clean up the memory associated with these objects by
   calling Rmpz_clear($op) for each object. Alternatively
   such objects will be cleaned up when the script ends.
   I don't know why you would want to create unblessed
   objects. The point is that you can if you want to.

=head1 FUNCTIONS

   See the GMP documentation at http://gmplib.org.

   These next 3 functions are demonstrated above:
   $rop   = Rmpz_init_set_str($str, $base); # 1 < $base < 37
   $rop   = Rmpz_init2($bits); # $bits > 0
   $str = Rmpz_get_str($r, $base); # 1 < $base < 37

   The following functions are simply wrappers around a GMP
   function of the same name. eg. Rmpz_swap() is a wrapper around
   mpz_swap().

   "$rop", "$op1", "$op2", etc. are Math::GMPz objects - the
   return values of one of the Rmpz_init* functions.
   They are in fact references to GMP structures.
   The "$rop" argument(s) contain the result(s) of the calculation
   being done, the "$op" argument(s) being the input(s) into that
   calculation.
   Generally, $rop, $op1, $op2, etc. can be the same perl variable,
   though usually they will be distinct perl variables
   referencing distinct GMP structures.
   Eg something like Rmpz_add($r1, $r1, $r1),
   where $r1 *is* the same reference to the same GMP structure,
   would add $r1 to itself and store the result in $r1. Think of it
   as $r1 += $r1. Otoh, Rmpz_add($r1, $r2, $r3), where each of the
   arguments is a different reference to a different GMP structure
   would add $r2 to $r3 and store the result in $r1. Think of it as
   $r1 = $r2 + $r3.
   Mostly, the first argument is the argument that
   stores the result and subsequent arguments provide the input values.
   Exceptions to this can be found in some of the functions that
   actually return a value, and, eg., the div_qr functions (which
   yield both quotient and remainder as their first *two* arguments).
   Like I say, see the GMP manual for details. I hope it's
   intuitively obvious or quickly becomes so. Also see the test
   suite that comes with the distro for some examples of usage.

   "$ui" means any integer that will fit into a C 'unsigned long int'.

   "$si" means any integer that will fit into a C 'signed long int'.

   "$double" means any number (not necessarily integer) that will fit
   into a C 'double'.

   "$bool" means a value (usually a 'signed long int') in which
   the only interest is whether it evaluates as true or not.

   "$str" simply means a string of symbols that represent a number,
   eg "1234567890987654321234567" which might be a base 10 number,
   or "zsa34760sdfgq123r5" which would have to represent at least
   a base 36 number (because "z" is a valid digit only in bases 36
   and higher). Valid bases for GMP numbers are 0 and 2..62 .

   "$NULL" is $Math::GMPz::NULL (the NULL mpz type).

   #####################

   INITIALIZING INTEGERS

   Normally, a variable should be initialized once only or at least be
   cleared, using `Rmpz_clear', between initializations.
   'DESTROY' (which calls 'Rmpz_clear') is automatically called on
   blessed objects whenever they go out of scope.

   First read the section 'MEMORY MANAGEMENT' (above).

   $rop = Math::GMPz::new();
   $rop = Math::GMPz->new();
   $rop = new Math::GMPz();
   $rop = Rmpz_init();
   $rop = Rmpz_init_nobless();
    Initialize $rop, and set its value to 0.

   $rop = Rmpz_init2($bits);
   $rop = Rmpz_init2_nobless($bits);
    Initialize $rop, with space for $bits bits, and set its value
    to 0. $bits is only the initial space, $rop will grow
    automatically if necessary, for subsequent values stored.
    `Rmpz_init2' makes it possible to avoid such reallocations if a
    maximum size is known in advance.

   Rmpz_realloc2($rop, $ui);
    Change the space allocated for $rop to $ui bits.  The value in
    $rop is preserved if it fits, or is set to 0 if not.

   ##################

   ASSIGNING INTEGERS


   Rmpz_set($rop, $op);
    Assign the value in $op to $rop.

   Rmpz_set_si($rop, $si);
    Assign the 'signed int', $si, to $rop.

   Rmpz_set_ui($rop, $ui);
    Assign the 'unsigned int', $ui, to $rop.

   Rmpz_set_d($rop, $double);
    Assign $double to $rop. (Truncate to an integer if necessary.)

   Rmpz_set_q($rop, $q); # $q is a Math::GMPq or GMP::Mpq object
    Assign $q to $rop. (Truncate to an integer if necessary.)

   Rmpz_set_f($rop, $f); # $f is a Math::GMPf or GMP::Mpf object
    Assign $f to $rop. (Truncate to an integer if necessary.)

   Rmpz_set_str($rop, $str, $base);
    Set $rop to the base $base value of $str. $base may vary from
    2 to 62.  If $base is 0, the actual base is determined from the
    leading characters: if the first two characters are "0x" or "0X",
    hexadecimal is assumed, otherwise if the first character is "0",
    octal is assumed, otherwise decimal is assumed.

   Rmpz_swap($rop1, $rop2); # swap the values

   ######################################

   COMBINED INITIALIZATION AND ASSIGNMENT

   NOTE: Do NOT use these functions if $rop has already
   been initialised. Instead use the Rmpz_set* functions
   in 'Assigning Integers' (above)

   First read the section 'MEMORY MANAGEMENT' (above).

   $rop = Math::GMPz->new($arg);
   $rop = Math::GMPz::new($arg);
   $rop = new Math::GMPz($arg);
    Returns a Math::GMPz object with the value of $arg.
    $arg can be either an integer (signed integer, unsigned
    integer, signed fraction or unsigned fraction) or a string that
    represents a numeric value. If $arg is a string, an optional
    additional argument that specifies the base of the number can be
    supplied to new(). If base is 0 (or not supplied) then the leading
    characters of the string are used: 0x or 0X for hex, 0b or 0B for
    binary, 0 for octal, or decimal otherwise. Legal values for the
    base are 0 and 2..62 .

   $rop = Rmpz_init_set($op);
   $rop = Rmpz_init_set_nobless($op);
   $rop = Rmpz_init_set_ui($ui);
   $rop = Rmpz_init_set_ui_nobless($ui);
   $rop = Rmpz_init_set_si($si);
   $rop = Rmpz_init_set_si_nobless($si);
   $rop = Rmpz_init_set_d($double);
   $rop = Rmpz_init_set_d_nobless($double);
   $rop = Rmpz_init_set_str($str, $base);
   $rop = Rmpz_init_set_str_nobless($str, $base);

   ###################

   CONVERTING INTEGERS


   $ui = Rmpz_get_ui($op);
    Return the value of $op as an `unsigned long'.
    The sign of $op is ignored, only the absolute value is used.

   $si = Rmpz_get_si($op);
    If $op fits into a `signed long int' return the value of $op.
    Otherwise return the least significant part of OP, with the
    same sign as $op. If $op is too big to fit in a `signed long
    int', the returned result is probably not very useful.  To
    find out if the value will fit, use the function
    `Rmpz_fits_slong_p'.

   $double = Rmpz_get_d($op);
     Place the value of $op into a normal perl scalar.

   ($double, $si) = Rmpz_get_d_2exp($op);
    Find $double and $si such that $double times 2 raised to
    $si, with 0.5<=abs($double)<1, is a good approximation to $op.

   $ul = Rmpz_getlimbn($op, $ui);
    Return limb number $ui from $op.  The sign of $op is ignored,
    just the absolute value is used.  The least significant limb
    is number 0. `Rmpz_size' can be used to find how many limbs
    make up $op. `Rmpz_getlimbn' returns zero if $ui is outside the
    range 0 to `Rmpz_size($op)-1'.

   $str = Rmpz_get_str($op, $base);
    Convert $op to a string of digits in base $base.
    The base may vary from -36..-2, 2..62.

   ##################

   INTEGER ARITHMETIC

   Rmpz_add($rop, $op1, $op2);
   Rmpz_add_ui($rop, $op, $ui);
    $rop = 2nd arg + 3rd arg.

   Rmpz_sub($rop, $op1, $op2);
   Rmpz_sub_ui($rop, $op, $ui);
   Rmpz_ui_sub($rop, $ui, $op);
    $rop = 2nd arg - 3rd arg.

   Rmpz_mul($rop, $op1, $op2);
   Rmpz_mul_si($rop, $op, $si);
   Rmpz_mul_ui($rop, $op, $ui);
    $rop = 2nd arg * 3rd arg.

   Rmpz_addmul($rop, $op1, $op2);
   Rmpz_addmul_ui($rop, $op, $ui);
    $rop += 2nd arg * 3rd arg.

   Rmpz_submul($rop, $op1, $op2);
   Rmpz_submul_ui($rop, $op, $ui);
    $rop -= 2nd arg * 3rd arg.

   Rmpz_mul_2exp($rop, $op, $ui);
    Set $rop to $op * (2 ** $ui).  This operation can
    also be defined as a left shift by $ui bits.

   Rmpz_div_2exp($rop, $op, $ui); # Same as Rmpz_fdiv_q_2exp
    Set $rop to $op / (2 ** $ui).  This operation can
    also be defined as a right shift by $ui bits.

   Rmpz_neg($rop, $op);
    $rop = -$op.

   Rmpz_abs($rop, $op);
    $rop = abs($op).

   ################

   INTEGER DIVISION

   `cdiv' rounds quotient up towards +infinity, and remainder
          will have the opposite sign to divisor.
         The `c' stands for "ceil".

   `fdiv' rounds quotient down towards -infinity, and remainder
          will have the same sign as divisor.
          The `f' stands for "floor".

   `tdiv' rounds quotient towards zero, and remainder
          will have the same sign as the number.
          The `t' stands for "truncate".

   Rmpz_div($rop, $op1, $op2); # Same as Rmpz_fdiv_q
   Rmpz_cdiv_q($rop, $op1, $op2);
   Rmpz_fdiv_q($rop, $op1, $op2);
   Rmpz_tdiv_q($rop, $op1, $op2);
    $rop = $op1 / $op2.

   Rmpz_cdiv_r($rop, $op1, $op2);
   Rmpz_fdiv_r($rop, $op1, $op2);
   Rmpz_tdiv_r($rop, $op1, $op2);
    $rop = $op1 % $op2.

   Rmpz_divmod($rop1, $rop2m $op1, $op2); # Same as Rmpz_fdiv_qr
   Rmpz_cdiv_qr($rop1, $rop2, $op1, $op2);
   Rmpz_fdiv_qr($rop1, $rop2, $op1, $op2);
   Rmpz_tdiv_qr($rop1, $rop1, $op1, $op2);
    $rop1 = $op1 / $op2.
    $rop2 = $op1 % $op2.

   $ul = Rmpz_div_ui($rop, $op, $ui); # Same as Rmpz_fdiv_q_ui
   $ul = Rmpz_cdiv_q_ui($rop, $op, $ui);
   $ul = Rmpz_fdiv_q_ui($rop, $op, $ui);
   $ul = Rmpz_tdiv_q_ui($rop, $op, $ui);
    $rop = $op / $ui.
    $ul = $op % $ui.

   $ul = Rmpz_cdiv_r_ui($rop, $op, $ui);
   $ul = Rmpz_fdiv_r_ui($rop $op, $ui);
   $ul = Rmpz_tdiv_r_ui($rop, $op, $ui);
    $rop = $op % $ui.
    $ul = $op % $ui.

   $ul = Rmpz_divmod_ui($rop1, $rop2, $op1, $ui); # Same as Rmpz_fdiv_qr_ui
   $ul = Rmpz_cdiv_qr_ui($rop1, $rop2, $op, $ui);
   $ul = Rmpz_fdiv_qr_ui($rop1, $rop2, $op, $ui);
   $ul = Rmpz_tdiv_qr_ui($rop1, $rop2, $op, $ui);
    $rop1 = $op / $ui.
    $rop2 = $op % $ui.
    $ul = $op % $ui.

   $ul = Rmpz_cdiv_ui($op, $ui);
   $ul = Rmpz_fdiv_ui($op, $ui);
   $ul = Rmpz_tdiv_ui($op, $ui);
    $ul = $op % $ui.

   Rmpz_cdiv_q_2exp($rop, $op, $ui);
   Rmpz_fdiv_q_2exp($rop, $op, $ui);
   Rmpz_tdiv_q_2exp($rop, $op, $ui);
    $rop = $op / (2 ** $ui). ie $rop is $op right-shifted
    by $ui bits.

   Rmpz_mod_2exp($rop, $op, $ui); # Same as Rmpz_fdiv_r_2exp
   Rmpz_cdiv_r_2exp($rop, $op, $ui);
   Rmpz_fdiv_r_2exp($rop, $op, $ui);
   Rmpz_tdiv_r_2exp($rop, $op, $ui);
    $rop = $op % (2 ** $ui).

   Rmpz_mod($rop, $op1, $op2);
    $rop = $op1 % $op2. The sign of the divisor is ignored.
    The result is never negative.

   $ul = Rmpz_mod_ui($rop, $op, $ui);
    $rop = $op % $ui.
    $ul = $op % $ui.
    The sign of the divisor is ignored. The result is never negative.

   Rmpz_divexact($rop, $op1, $op2);
   Rmpz_divexact_ui($rop, $op, $ui);
    $rop = 2nd arg / 3rd arg.
    These 2 functions provide correct results only when it
    is known that the 3rd arg divides the 2nd arg.

   $bool = Rmpz_divisible_p($op1, $op2);
   $bool = Rmpz_divisible_ui_p($op, $ui);
   $bool = Rmpz_divisible_2exp_p($op, $ui);
    Return non-zero if 1st arg is exactly divisible by 2nd arg,
    or in the case of `Rmpz_divisible_2exp_p' by 2 ** 2nd arg.

   $bool = Rmpz_congruent_p($op1, $op2, $op3);
   $bool = Rmpz_congruent_ui_p($op, $ui, $ui);
   $bool = Rmpz_congruent_2exp_p($op1, $op2, $ui);
    Return non-zero if 1st arg is congruent to 2nd arg modulo
    3rd arg, or in the case of `Rmpz_congruent_2exp_p' modulo
    2 ** 3rd arg.

   ######################

   INTEGER EXPONENTIATION

   Rmpz_powm($rop, $op1, $op2, $op3);
   Rmpz_powm_sec($rop, $op1, $op2, $op3); # gmp-5.0 and later only
    $rop = ($op1 ** $op2 ) % $op3
    In the case of Rmpz_powm_sec, $op2 must be > 0, and $op3 must
    be odd.

   Rmpz_powm_ui($rop, $op1, $ui, $op2);
    $rop = ($op1 ** $ui) % $op2

   Rmpz_pow_ui($rop, $op, $ui);
    $rop = $op ** $ui

   Rmpz_ui_pow_ui($rop, $ui1, $ui2);
    $rop = $ui1 ** $ui2

   #############

   INTEGER ROOTS

   Rmpz_root($rop, $op, $ui);
    $rop = $op ** (1 / $ui).

   Rmpz_sqrt($rop, $op);
    $rop = $op ** 0.5.

   Rmpz_sqrtrem($rop1, $rop2, $op);
    $rop1 = $op ** 0.5.
    $op = $rop2 + ($rop1 ** 2).

   $bool = Rmpz_perfect_power_p($op);
    Return zero if $op is not a perfect power.
    Else return non-zero.

   $bool = Rmpz_perfect_square_p($op);
    Return zero if $op is not a perfect square.
    Else return non-zero.

   ##########################

   NUMBER THEORETIC FUNCTIONS

   $si = Rmpz_probab_prime_p($rop, $ui);
    Determine whether $rop is prime. Return 2 if $rop is
    definitely prime, return 1 if $rop is probably prime
    (without being certain), or return 0 if $rop is definitely
    composite. This function does some trial divisions, then
    some Miller-Rabin probabilistic primality tests.  $ui
    controls how many such tests are done, 5 to 10 is a
    reasonable number, more will reduce the chances of a
    composite being returned as "probably prime".
    Miller-Rabin and similar tests can be more properly called
    compositeness tests.  Numbers which fail are known to be
    composite but those which pass might be prime or might be
    composite. Only a few composites pass, hence those which
    pass are considered probably prime.

   Rmpz_nextprime($rop, $op);
    This function uses a probabilistic algorithm to identify
    primes. For practical purposes it's adequate, the chance
    of a composite passing will be extremely small.

   Rmpz_gcd($rop, $op1, $op2);
    Set $rop to the greatest common divisor of $op1 and $op2.
    The result is always positive even if one or both input
    operands are negative.

   $ui2 = Rmpz_gcd_ui($rop, $op, $ui1);  # GCD in $ui2 & $rop
   $ui2 = Rmpz_gcd_ui($NULL, $op, $ui1); # GCD in $ui2 only
    Compute the greatest common divisor of $op and $ui1.
    Store the result in $rop (iff $rop is not $Math::GMPz::NULL).
    If the result is small enough to fit in an `unsigned long
    int', it is returned.  If the result does not fit, 0 is
    returned, and the result is equal to the argument $op.
    Note that the result will always fit if $ui1 is non-zero.

   Rmpz_gcdext($rop1, $rop2, $rop3, $op1, $op2);
   Rmpz_gcdext($rop1, $rop2, $NULL, $op1, $op2);
    Set $rop1 to the greatest common divisor of $op1 and $op2,
    and in addition set $rop2 and $rop3 to coefficients
    satisfying $op1*$rop2 + $op2*$rop3 = $rop1. $rop1 is
    always positive, even if one or both of $op1 and $op2
    are negative.
    If $rop3 is $Math::GMPz::NULL then that value is not
    computed.

   Rmpz_lcm($rop, $op1, $op2);
   Rmpz_lcm_ui($rop, $op, $ui);
    Set $rop to the least common multiple of 2nd and 3rd args.
    $rop is always positive, irrespective of the signs of the
    2nd and 3rd args. $rop will be zero if either
    2nd or 3rd arg is zero.

   $bool = Rmpz_invert($rop, $op1, $op2);
    Compute the inverse of $op1 modulo $op2 and put the result
    in $rop. If the inverse exists, the return value is
    non-zero and $rop will satisfy 0 <= $rop < $op2.
    If an inverse doesn't exist the return value is zero and
    $rop is undefined.

   $si = Rmpz_jacobi($op1, $op2);
    Calculate the Jacobi symbol ($op1/$op2). This is defined
    only for $op2 odd.

   $si = Rmpz_legendre($op1, $op2);
    Calculate the Legendre symbol ($op1/$op2). This is defined
    only for $op2 an odd positive prime, and for such $op2
    it's identical to the Jacobi symbol.

   $si = Rmpz_kronecker($op1, $op2);
   $si = Rmpz_kronecker_si($op, $si);
   $si = Rmpz_kronecker_ui($op, $ui);
   $si = Rmpz_si_kronecker($si, $op);
   $si = Rmpz_ui_kronecker($ui, $op);
    Calculate the Jacobi symbol (1st arg/2nd arg) with the
    Kronecker extension (a/2)=(2/a) when a odd, or (a/2)=0
    when a even. When 2nd arg is odd the Jacobi symbol and
    Kronecker symbol are identical, so `mpz_kronecker_ui'
    etc can be used for mixed precision Jacobi symbols too.

   $ui = Rmpz_remove($rop, $op1, $op2);
    Remove all occurrences of the factor $op2 from $op1 and
    store the result in $rop.  The return value is how many
    such occurrences were removed.

   Rmpz_fac_ui($rop, $ui);
    Set $rop to the factorial of $ui.

   Rmpz_2fac_ui($rop, $ui); # Available only with gmp-5.1.0
                            # or later
    Set $rop to the double-factorial (n!!) of $ui.

   Rmpz_mfac_uiui($rop, $ui1, $u2); # Available only with
                                    # gmp-5.1.0 or later
    Set $rop to the $ui2-multi-factorial of $ui1, $ui2.

   Rmpz_primorial_ui($rop, $ui); # Available only with gmp-5.1.0
                                 # or later
    Set $rop to the primorial of $ui, i.e. the product of all
    positive prime numbers smaller than or equal to $ui.

   Rmpz_bin_ui($rop, $op, $ui);
   Rmpz_bin_uiui($rop, $ui, $ui);
   Rmpz_bin_si($rop, $op, $si);
    Compute the binomial coefficient 2nd arg over 3rd arg and
    store the result in $rop.  Negative values of 2nd arg are
    supported by `Rmpz_bin_ui' & `Rmpz_bin_si'.
    (NOTE: The GMP library does not provide an `mpz_bin_si'
    function.)

   Rmpz_fib_ui($rop, $ui);
   Rmpz_fib2_ui($rop1, $rop2, $ui);
    `Rmpz_fib_ui' sets $rop to to F[$ui], the $ui'th
    Fibonacci number. `Rmpz_fib2_ui' sets $rop1 to F[$ui],
    and $rop2 to F[$ui-1]. These functions are designed for
    calculating isolated Fibonacci numbers.  When a sequence
    of values is wanted it's best to start with `Rmpz_fib2_ui'
    and iterate the defining F[n+1]=F[n]+F[n-1] or similar.

   Rmpz_lucnum_ui($rop, $ui);
   Rmpz_lucnum2_ui($rop1, $rop2, $ui);
    `Rmpz_lucnum_ui' sets $rop to to L[$ui], the $ui'th
    Lucas number. `Rmpz_lucnum2_ui' sets $rop1 to L[$ui],
    and $rop2 to L[$ui-1]. These functions are designed for
    calculating isolated Lucas numbers.  When a sequence of
    values is wanted it's best to start with `Rmpz_lucnum2_ui'
    and iterate the defining L[n+1]=L[n]+L[n-1] or similar.

   ###################

   INTEGER COMPARISONS

   $si = Rmpz_cmp($op1, $op2);
   $si = Rmpz_cmp_d($op, $double);
   $si = Rmpz_cmp_si($op, $si);
   $si = Rmpz_cmp_ui($op, $ui);
    Compare 1st and 2nd args.  Return a positive value if
    1st arg > 2nd arg, zero if 1st arg = 2nd arg, or a
    negative value if 1st arg < 2nd arg.

   $si = Rmpz_cmpabs($op1, $op2);
   $si = Rmpz_cmpabs_d($op, $double);
   $si = Rmpz_cmpabs_ui($op, $ui);
    Compare the absolute values of 1st and 2nd args.  Return
    a positive value if abs(1st arg) > abs(2nd arg), zero if
    abs(1st arg) = abs(2nd arg), or a negative value if
    abs(1st arg) < abs(2nd arg).

   $si = Rmpz_sgn($op);
    Return +1 if $op > 0, 0 if $opP = 0, and -1 if $op < 0.

   ##############################

   INTEGER LOGIC AND BIT FIDDLING

   Rmpz_and($rop, $op1, $op2);
    Set $rop to $op1 logical-and $op2.

   Rmpz_ior($rop, $op1, $op2);
    Set $rop to $op1 inclusive-or $op2.

   Rmpz_xor($rop, $op1, $op2);
    Set $rop to $op1 exclusive-or $op2.

   Rmpz_com($rop, $op);
    Set $rop to the one's complement of $op.

   $ui = Rmpz_popcount($op);
    If $op>=0, return the population count of $op, which is the
    number of 1 bits in the binary representation.  If $op<0, the
    number of 1s is infinite, and the return value is MAX_ULONG,
    the largest possible `unsigned long'.

   $ui = Rmpz_hamdist($op1, $op2);
    If $op1 and $op2 are both >=0 or both <0, return the hamming
    distance between the two operands, which is the number of bit
    positions where $op1 and $op2 have different bit values.  If
    one operand is >=0 and the other <0 then the number of bits
    different is infinite, and the return value is MAX_ULONG,
    the largest possible `unsigned long'.

   $ui = Rmpz_scan0($op, $ui);
   $ui = Rmpz_scan1($op, $ui);
    Scan $op, starting from bit index $ui, towards more
    significant bits, until the first 0 or 1 bit (respectively)
    is found.  Return the index of the found bit. If the bit at
    index $ui is already what's sought, then $ui is returned.
    If there's no bit found, then MAX_ULONG is returned.  This
    will happen in `Rmpz_scan0' past the end of a positive
    number, or `Rmpz_scan1' past the end of a negative.

   Rmpz_setbit($rop, $ui);
    Set bit index $ui in $rop.

   Rmpz_clrbit($rop, $ui);
    Clear bit index $ui in $rop.

   $si = Rmpz_tstbit($op, $ui);
    Test bit index $ui in $op and return 0 or 1 accordingly.

   ###############

   I/O of INTEGERS

   $bytes_written = Rmpz_out_str([$prefix,] $op, $base [, $suffix]);
    BEST TO USE TRmpz_out_str INSTEAD.
    Output $op to STDOUT, as a string of digits in base $base.
    The base may vary from -36..-2, 2..62. Return the number
    of bytes written, or if an error occurred,return 0.
    The optional arguments ($prefix and $suffix) are strings
    that will be prepended/appended to the mpz_out_str output.
    $bytes_written does not include the bytes contained in
    $prefix and $suffix.

   $bytes_written = TRmpz_out_str([$prefix,] $stream, $base, $op, [, $suffix]);
    As for Rmpz_out_str, except that there's the capability to print
    to somewhere other than STDOUT. Note that the order of the args
    is different (to match the order of the mpz_out_str args).
    To print to STDERR:
       TRmpz_out_str(*stderr, $base, $digits, $op);
    To print to an open filehandle (let's call it FH):
       TRmpz_out_str(\*FH, $base, $digits, $op);

   $bytes_written = Rmpz_out_raw(\*FH, $op);
    Output $op to filehandle FH, in raw binary format. The integer is
    written in a portable format, with 4 bytes of size information, and
    that many bytes of limbs. Both the size and the limbs are written
    in decreasing significance order (i.e., in big-endian). The output
    can be read with mpz_inp_raw.

   $bytes_read = Rmpz_inp_str($rop, $base);
    BEST TO USE TRmpz_inp_str instead.
    Input a string in base $base from STDIN, and put the read
    integer in $rop. The base may vary from 2 to 62.  If $base
    is 0, the actual base is determined from the leading
    characters: if the first two characters are `0x' or `0X',
    hexadecimal is assumed, otherwise if the first character is
   `0', octal is assumed, otherwise decimal is assumed.
    Return the number of bytes read, or if an error occurred, return 0.

   $bytes_read = TRmpz_inp_str($rop, $stream, $base);
    As for Rmpz_inp_str, except that there's the capability to read
    from somewhere other than STDIN.
    To read from STDIN:
       TRmpz_inp_str($rop, *stdin, $base);
    To read from an open filehandle (let's call it FH):
       TRmpz_inp_str($rop, \*FH, $base);

    $bytes_read = Rmpz_inp_raw($rop, \*FH);
     Input from filehandle FH in the format written by Rmpz_out_raw,
     and put the result in $rop. Return the number of bytes read, or
     if an error occurred, return 0.


   #######################

   RANDOM NUMBER FUNCTIONS

   In the random number functions, @r is an array of
   Math::GMPz objects (one for each random number that is
   required). $how_many is the number of random numbers you
   want and must be equal to scalar(@r). $bits is simply the
   number of random bits required. Before calling the random
   number functions, $state must be initialised and seeded.

   $state = rand_init($op); # $op is the seed.
    Initialises and seeds $state, ready for use with the random
    number functions. However, $state has not been blessed into
    any package, and therefore does not get cleaned up when it
    goes out of scope. To avoid memory leaks you therefore need
    to call 'rand_clear($state);' once you have finished with it
    and before it goes out of scope. Also, it uses the default
    algorithm. Consider using the following initialisation and
    seeding routines - they provide a choice of algorithm, and
    there's no need to call rand_clear() when you've finished with
    them.

   $state = zgmp_randinit_default();
    This is the Math::GMPz interface to the gmp library function
   'gmp_randinit_default'.
    $state is blessed into package Math::GMPz::Random and will be
    automatically cleaned up when it goes out of scope.
    Initialize $state with a default algorithm. This will be a
    compromise between speed and randomness, and is recommended for
    applications with no special requirements. Currently this is
    the gmp_randinit_mt function (Mersenne Twister algorithm).

   $state = zgmp_randinit_mt();
    This is the Math::GMPz interface to the gmp library function
   'gmp_randinit_mt'.
    Currently identical to zgmp_randinit_default().

   $state = zgmp_randinit_lc_2exp($mpz, $ui, $m2exp);
    This is the Math::GMPz interface to the gmp library function
   'gmp_randinit_lc_2exp'.
    $state is blessed into package Math::GMPz::Random and will be
    automatically cleaned up when it goes out of scope.
    Initialize $state with a linear congruential algorithm
    X = ($mpz*X + $ui) mod (2 ** $m2exp). The low bits of X in this
    algorithm are not very random. The least significant bit will have a
    period no more than 2, and the second bit no more than 4, etc. For
    this reason only the high half of each X is actually used.
    When a random number of more than m2exp/2 bits is to be generated,
    multiple iterations of the recurrence are used and the results
    concatenated.

   $state = zgmp_randinit_lc_2exp_size($ui);
    This is the Math::GMPz interface to the gmp library function
   'gmp_randinit_lc_2exp_size'.
    $state is blessed into package Math::GMPz::Random and will be
    automatically cleaned up when it goes out of scope.
    Initialize state for a linear congruential algorithm as per
    gmp_randinit_lc_2exp. a, c and m2exp are selected from a table,
    chosen so that $ui bits (or more) of each X will be used,
    ie. m2exp/2 >= $ui.
    If $ui is bigger than the table data provides then the function fails
    and dies with an appropriate error message. The maximum value for $ui
    currently supported is 128.

   $state2 = zgmp_randinit_set($state1);
    This is the Math::GMPz interface to the gmp library function
   'gmp_randinit_set'.
    $state2 is blessed into package Math::GMPz::Random and will be
    automatically cleaned up when it goes out of scope.
    Initialize $state2 with a copy of the algorithm and state from
    $state1.

   $state = zgmp_randinit_default_nobless();
   $state = zgmp_randinit_mt_nobless();
   $state = zgmp_randinit_lc_2exp_nobless($mpz, $ui, $m2exp);
   $state2 = zgmp_randinit_set_nobless($state1);
    As for the above comparable function, but $state is not blessed into
    any package. (Generally not useful - but they're available if you
    want them.)

   zgmp_randseed($state, $mpz);
   zgmp_randseed_ui($state, $ui);
    These are the Math::GMPz interfaces to the gmp library functions
   'gmp_randseed' and 'gmp_randseed_ui'.
    Seed an initialised (but not yet seeded) $state with $mpz/$ui.

   $ui = zgmp_urandomb_ui($state, $bits);
    This is the Math::GMPz interface to the gmp library function
    'gmp_urandomb_ui'.
    Return a uniformly distributed random number of $bits bits, ie. in
    the range 0 to 2 ** ($bits - 1) inclusive. $bits must be less than or
    equal to the number of bits in an unsigned long.

   $ui2 = zgmp_urandomm_ui($state, $ui1);
    This is the Math::GMPz interface to the gmp library function
    'gmp_urandomm_ui'.
    Return a uniformly distributed random number in the range 0 to
    $ui1 - 1, inclusive.

   Rmpz_urandomm(@r, $state, $mpz, $how_many);
    Generate $how_many uniform random integers in the range
    0 to $op-1, inclusive.

   Rmpz_urandomb(@r, $state, $bits, $how_many);
    Generate $how_many uniformly distributed random integers
    in the range 0 to 2**($bits-1), inclusive.

   Rmpz_rrandomb(@r, $state, $bits, $how_many);
    Generate $how_many random integers with long strings of
    zeros and ones in the binary representation. Useful for
    testing functions and algorithms, since this kind of random
    numbers have proven to be more likely to trigger corner-case bugs.
    The random number will be in the range 0 to 2**($bits-1), inclusive.

   zgmp_randclear($state);
   rand_clear($state);
    Destroys $state, as also does Math::GMPz::Random::DESTROY - three
    identical functions.
    Use only if $state is an unblessed object - ie if it was initialised
    using rand_init() or one of the zgmp_randinit*_nobless functions.

   #########################

   INTEGER IMPORT AND EXPORT

   Rmpz_import($rop, $len, $order, $size, $endian, $nails, $bstr);

    Take a binary string ("$bstr") and convert it to a GMP
    bignum structure, treating the string as a base 256
    number. "$rop" is a Math::GMPz object holding that number.
    "$len" is the length of the string segment to be
    converted to the GMP bignum. Normally, $len = length($bstr),
    but you can opt not to take the entire string if you like.

    Usually ($order, $size, $endian, $nails) = (1, 1, 0, 0);

    See the GMP manual for a full explanation of what these
    variables mean.

   $bstr = Rmpz_export($order, $size, $endian, $nails, $op);

    Rmpz_export() is simply the reverse of Rmpz_import().
    It returns a base 256 string representation of the
    number held by the Math::GMPz object, "$op".

   ###############################

   MISCELLANEOUS INTEGER FUNCTIONS

   $bool = Rmpz_fits_ulong_p($op);
   $bool = Rmpz_fits_slong_p($op);
   $bool = Rmpz_fits_uint_p($op);
   $bool = Rmpz_fits_sint_p($op);
   $bool = Rmpz_fits_ushort_p($op);
   $bool = Rmpz_fits_sshort_p($op);
    Return non-zero iff the value of $op fits an `unsigned long int',
    `signed long int', `unsigned int', `signed int', `unsigned short
    int', or `signed short int', respectively. Otherwise, return zero.

   $bool = Rmpz_odd_p($op);
   $bool = Rmpz_even_p($op);
    Determine whether $op is odd or even, respectively.
    Return non-zero if yes, zero if no.

   $ui = Rmpz_size($op);
    Return the size of $op measured in number of limbs.
    If $op is zero, the returned value will be zero.

   $ui = Rmpz_sizeinbase($op, $base);
    Return the size of $op measured in number of digits in base
    $base. The base may vary from 2 to 62.  The sign of $op is
    ignored, just the absolute value is used.  The result will be
    exact or 1 too big.  If $base is a power of 2, the result will
    always be exact. If $op is zero the return value is always 1.

   ####################

   OPERATOR OVERLOADING

    Overloading works with numbers, strings, Math::GMPz objects
    and, to a limited extent, Math::MPFR objects (iff version 3.13
    or later of Math::MPFR has been installed).

   The following operators are overloaded:
    + - * / %
    += -= *= /= %=
    << >> <<= >>=
    & | ^ ~
    &= |= ^=
    < <= > >= == != <=>
    ! abs

    Division uses 'tdiv' (see 'Integer Division', above).
    Check that '~', '%', and '%=' are working as you expect
    (especially in relation to negative values).

    Atempting to use the overloaded operators with objects that
    have been blessed into some package other than 'Math::GMPz'
    or 'Math::MPFR' (limited applications) will not work.
    Math::MPFR objects can be used only with '+', '-', '*', '/'
    and '**' operators, and will work only if Math::MPFR is at
    version 3.13 or later - in which case the operation will
    return a Math::MPFR object.

    In those situations where the overload subroutine operates on 2
    perl variables, then obviously one of those perl variables is
    a Math::GMPz object. To determine the value of the other variable
    the subroutine works through the following steps (in order),
    using the first value it finds, or croaking if it gets
    to step 6:

    1. If the variable is an unsigned long then that value is used.
       The variable is considered to be an unsigned long if
       (perl 5.8) the UOK flag is set or if (perl 5.6) SvIsUV()
       returns true.

    2. If the variable is a signed long int, then that value is used.
       The variable is considered to be a signed long int if the
       IOK flag is set. (In the case of perls built with
       -Duse64bitint, the variable is treated as a signed long long
       int if the IOK flag is set.)

    3. If the variable is a double, then that value is used. The
       variable is considered to be a double if the NOK flag is set.

    4. If the variable is a string (ie the POK flag is set) then the
       value of that string is used. Octal strings must begin with
       '0', hex strings must begin with either '0x' or '0X' -
       otherwise the string is assumed to be decimal. If the POK
       flag is set, but the string is not a valid base 8, 10, or 16
       number, the subroutine croaks with an appropriate error
       message.

    5. If the variable is a Math::GMPz object (or, for operators
       specified above, a Math::MPFR object) then the value of that
       object is used.

    6. If none of the above is true, then the second variable is
       deemed to be of an invalid type. The subroutine croaks with
       an appropriate error message.

    If the second operand is a 'double' (ie if the other
    operand's NOK flag is set) then it is first truncated
    to an integer value before the operation is performed.

    For example:
    my $x = Rmpz_init_set_ui(112);
    $x *= 2.9;
    print "$x"; # prints 224

    Atempting to use the overloaded operators with objects that
    have been blessed into some package other than 'Math::GMPz'
    will not work.

   #####

   OTHER

   $GMP_version = Math::GMPz::gmp_v;
    Returns the version of the GMP library (eg 4.2.3) being used by
    Math::GMPz. The function is not exportable.

   $GMP_cc = Math::GMPz::__GMP_CC;
   $GMP_cflags = Math::GMPz::__GMP_CFLAGS;
    If Math::GMPz has been built against gmp-4.2.3 or later,
    returns respectively the CC and CFLAGS settings that were used
    to compile the gmp library against which Math::GMPz was built.
    (Values are as specified in the gmp.h that was used to build
    Math::GMPz.)
    Returns undef if Math::GMPz has been built against an earlier
    version of the gmp library.
    (These functions are in @EXPORT_OK and are therefore exportable
    by request. They are not listed under the ":mpz" tag.)


   $major = Math::GMPz::__GNU_MP_VERSION;
   $minor = Math::GMPz::__GNU_MP_VERSION_MINOR;
   $patchlevel = Math::GMPz::__GNU_MP_VERSION_PATCHLEVEL;
    Returns respectively the major, minor, and patchlevel numbers
    for the GMP library version used to build Math::GMPz. Values are
    as specified in the gmp.h that was used to build Math::GMPz.
    (These functions are in @EXPORT_OK and are therefore exportable
    by request. They are not listed under the ":mpz" tag.)

   ################

   FORMATTED OUTPUT

   NOTE: The format specification can be found at:
   http://gmplib.org/manual/Formatted-Output-Strings.html#Formatted-Output-Strings
   However, the use of '*' to take an extra variable for width and
   precision is not allowed in this implementation. Instead, it is
   necessary to interpolate the variable into the format string - ie,
   instead of:
     Rmpz_printf("%*Zd\n", $width, $mpz);
   we need:
     Rmpz_printf("%${width}Zd\n", $mpz);

   $si = Rmpz_printf($format_string, $var);

    This function changed with the release of Math-GMPz-0.27.
    Now (unlike the GMP counterpart), it is limited to taking 2
    arguments - the format string, and the variable to be formatted.
    That is, you can format only one variable at a time.
    If there is no variable to be formatted, then the final arg
    can be omitted - a suitable dummy arg will be passed to the XS
    code for you. ie the following will work:
     Rmpz_printf("hello world\n");
    Returns the number of characters written, or -1 if an error
    occurred.

   $si = Rmpz_fprintf($fh, $format_string, $var);

    This function (unlike the GMP counterpart) is limited to taking
    3 arguments - the filehandle, the format string, and the variable
    to be formatted. That is, you can format only one variable at a time.
    If there is no variable to be formatted, then the final arg
    can be omitted - a suitable dummy arg will be passed to the XS
    code for you. ie the following will work:
     Rmpz_fprintf($fh, "hello world\n");
    Returns the number of characters written, or -1 if an error
    occurred.

   $si = Rmpz_sprintf($buffer, $format_string, [$var,] $buflen);

    This function (unlike the GMP counterpart) is limited to taking
    4 arguments - the buffer, the format string, the variable to be
    formatted and the buffer length. If there is no variable to be
    formatted, then the "$var" arg can be omitted - a suitable dummy
    arg will be passed to the XS code for you. ie the following will
    work:
     Rmpz_sprintf($buffer, "hello world\n", 12);
    $buflen must be large enough to accommodate the formatted string,
    Sets $buffer to the formatted string and returns the number of
    characters written, or -1 if an error occurred.

   $si = Rmpz_snprintf($buffer, $bytes, $format_string, [$var,] $buflen);

    Form a null-terminated string in $buffer. No more than $bytes
    bytes will be written. To get the full output, $bytes must be
    enough for the string and null-terminator. $buflen must be large
    enough to accommodate the string and null-terminator..
    The return value is the total number of characters which ought
    to have been produced, excluding the terminating null.
    If $si >= $bytes then the actual output has been truncated to
    the first $bytes-1 characters, and a null appended.
    This function (unlike the GMP counterpart) is limited to taking
    5 arguments - the buffer, the maximum number of bytes to be
    returned, the format string, the variable to be formatted, and
    the length of the buffer to which the formatted string will be
    written.
    If there is no variable to be formatted, then the "$var" arg can
    be omitted - a suitable dummy arg will be passed to the XS code
    for you. ie the following will work:
     Rmpz_snprintf($buffer, 6 "hello world", 12);

   ###################
   ###################

=head1 BUGS

    You can get segfaults if you pass the wrong type of
    argument to the functions - so if you get a segfault, the
    first thing to do is to check that the argument types
    you have supplied are appropriate.

=head1 LICENSE

    This program is free software; you may redistribute it and/or
    modify it under the same terms as Perl itself.
    Copyright 2006-20011, 2013 Sisyphus

=head1 AUTHOR

    Sisyphus <sisyphus at(@) cpan dot (.) org>

=cut
