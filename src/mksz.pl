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

my $def_sz      = [qw(9px 12px 16px 20px 24px)];
my $smol_sz     = [qw(8px 10px 12px 14px 18px)];

my $border_sz   = [qw(1px 1px 1px 1px 4px)];
my $border_rad  = [qw(1px 1px 2px 3px 4px)];

my $h1_sz       = [qw(14px 16px 18px 32px 48px)];
my $h2_sz       = [qw(12px 14px 16px 28px 32px)];
my $h3_sz       = [qw(10px 12px 12px 24px 28px)];

my $hed_y       = [qw(42px 44px 48px 96px 128px)];
my $fa_width    = [qw(5px 7px 9px 16px 24px)];

my $menu_height = [qw(7px 10px 12px 22px 30px)];
my $menu_pad    = [qw(1px 2px 3px 4px 5px)];

# ---   *   ---   *   ---

my $menu_height_p = [qw(12px 16px 22px 28px 33px)];
my $profpic_sz     = [qw(
  74px 96px 128px 156px 224px

)];

my $profpic_top = [qw(
  25px 25px 20px 28px 12px

)];

my $profpic_mar_left = [qw(
  7.5% 13.5% 17.5% 20% 18%

)];

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

  q[.ctct.button]=>[
    q[font-size]     => [@$def_sz],

  ],

  q[.menu]=>[
    q[height]         => [@$menu_height],

#    q[padding-top]    => [@$menu_pad],
#    q[padding-bottom] => [@$menu_pad],

  ],

  q[.menu-item]=>[
    q[font-size]      => [@$smol_sz],

  ],

  q[.ltop.menu]=>[
    q[height]=>[@$menu_height_p],

  ],

  q[.profpic]=>[
    q[height] => [@$profpic_sz],
    q[width]  => [@$profpic_sz],
    q[top]    => [@$profpic_top],

    q[margin-left]=>[@$profpic_mar_left],

  ],

  q[.langsel]=>[
    q[font-size] => [@$smol_sz],

  ],

);

# ---   *   ---   *   ---

my $brk=Emit::Css::by_break($brkp,@data);
say $brk;

# ---   *   ---   *   ---
1; # ret
