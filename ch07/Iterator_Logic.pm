#!/usr/bin/perl

# Iterator Logic, a package from chapter 07 of HOP
package Iterator_Logic;
use base 'Exporter';
@EXPORT = qw(i_or_ i_or i_and_ i_without_ i_without);

sub i_or_ {
    my ($cmp, $a, $b) = @_;
    my ($av, $bv) = ($a->(), $b->());
    return sub {
        my $rv;
        if (!defined $av && !defined $rv) {
            return;
        } elsif (!defined $av) {
            $rv = $bv;
            $bv = $b->();
        } elsif (!defined $bv) {
            $rv = $av;
            $av = $a->();
        } else {
            my $d = $cmp->($av, $bv);
            if ($d < 0) { $rv = $av; $av = $a->() }
            elsif ($d > 0) { $rv = $bv; $bv = $b->() }
            else { $rv = $av; $av = $a->(); $bv = $b->() }
        }
        return $rv;
    };
}

use Curry;
BEGIN { *i_or = curry(\&i_or_) }
