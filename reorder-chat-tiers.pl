#!/usr/bin/perl -wp0777

use warnings;
use strict;
use sort 'stable';

# One dependent tier.
my $depLine = qr/^%[^:]+.*?\n(?!\t)/ms;

# Change up a chunk of dependent tiers.
s/($depLine+)(?=[@*])/reorder($1)/eg;

# Reorder a chunk of dependent tiers.
sub reorder {
    my $lines = shift;
    join '',
            map { $_->[0] }
            sort { $a->[1] <=> $b->[1] }
            map { [$_, ordering($_)] }
            $lines =~ /$depLine/g;
}

# Front-load mor/trn and gra/grt
sub ordering {
    my $line = shift;
    my ($dep) = $line =~ /^%([^:]+)/;

    if ($dep eq 'mor' || $dep eq 'trn') {
        0
    } elsif ($dep eq 'gra' || $dep eq 'grt') {
        1
    } else {
        2
    }
}
