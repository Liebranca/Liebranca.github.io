#!/usr/bin/perl

# ---   *   ---   *   ---
# deps

package main;

  use v5.36.0;
  use strict;
  use warnings;

  use English qw(-no_match_vars);

  use lib $ENV{'ARPATH'}.'/lib/sys/';

  use Style;
  use Arstd::IO;

  use lib $ENV{'ARPATH'}.'/avtomat/';

  use Emit::Std;
  use Emit::Css;

# ---   *   ---   *   ---
# acknowledge codegen

say

  Emit::Std::note(
    'IBN-3DILA',q[/*]

  ),

  q[*/],
  "\n"

;

# ---   *   ---   *   ---

#say q[@import url('./default.css');];
#say orc(glob '~/wshit/styles/default.css');

# ---   *   ---   *   ---

my $def_sz      = [qw(5px 7px 9px 16px 24px)];
my $smol_sz     = [qw(4px 6px 8px 14px 18px)];

my $border_sz   = [qw(1px 1px 1px 1px 4px)];
my $border_rad  = [qw(1px 1px 2px 3px 4px)];

my $h1_sz       = [qw(8px 12px 16px 32px 48px)];
my $h2_sz       = [qw(6px 10px 12px 24px 32px)];
my $h3_sz       = [qw(5px 8px 10px 20px 28px)];

my $hed_y       = [qw(24px 32px 48px 96px 128px)];
my $fa_width    = [qw(5px 7px 9px 16px 24px)];

my $menu_height = [qw(7px 10px 12px 22px 30px)];
my $menu_pad    = [qw(1px 2px 3px 4px 5px)];

# ---   *   ---   *   ---

my $brkp=[319,320,480,768,1200];
my @data=(

  q[*]=>[

    q[font-size]      => [@$def_sz],
    q[border-radius]  => [@$border_rad],
    q[border-width]   => [@$border_sz],

  ],

# ---   *   ---   *   ---

  q[h1]=>[
    q[font-size]=>[@$h1_sz],

  ],

  q[h2]=>[
    q[font-size]=>[@$h2_sz],

  ],

  q[h3]=>[
    q[font-size]=>[@$h3_sz],

  ],

# ---   *   ---   *   ---

  q[.ltop, .rtop]=>[
    q[height]=>[@$hed_y],

  ],

  q[.fa]=>[
    q[font-size]     => [@$def_sz],
    q[border-radius] => [@$border_rad],

    q[width]         => [@$fa_width],
    q[height]        => [@$fa_width],

  ],

  q[.menu]=>[
    q[height]         => [@$menu_height],

#    q[padding-top]    => [@$menu_pad],
#    q[padding-bottom] => [@$menu_pad],

  ],

  q[.menu-item]=>[
    q[font-size]      => [@$smol_sz],

  ],

);

# ---   *   ---   *   ---

my $brk=Emit::Css::by_break($brkp,@data);
say $brk;

# ---   *   ---   *   ---
1; # ret
