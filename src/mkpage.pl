#!/usr/bin/perl
# ---   *   ---   *   ---
# MKPAGE
# You like code duplication?
#
# LIBRE SOFTWARE
# Licensed under GNU GPL3
# be a bro and inherit
#
# CONTRIBUTORS
# lyeb,

# ---   *   ---   *   ---

package main;

  use v5.36.0;
  use strict;
  use warnings;

  use Readonly;
  use English qw(-no_match_vars);

  use lib $ENV{'ARPATH'}.'/lib/sys/';
  use Style;

  use lib $ENV{'ARPATH'}.'/lib/';

  use Lang::Def;
  use Emit::Std;

# ---   *   ---   *   ---
# info

  our $VERSION = v0.00.1;#b
  our $AUTHOR  = 'IBN-3DILA';

# ---   *   ---   *   ---
# ROM

Readonly our $HEAD=>q~

<head>

<!-- ---   *   ---   *   ----->
<!--info-->

  <meta
    version = v0.00.6b
    author  = "IBN-3DILA"

  >

  <title>
    CV

  </title>

  <link

    rel  = "icon"
    type = "image/png"
    href = "./data/favicon.png"

  >

<!-- ---   *   ---   *   ----->
<!--boiler-->

  <meta charset="UTF-8">

  <meta
    name    = "viewport"
    content = "width=device-width"
    content = "initial-scale=1.0"

  >

  <meta
    http-equiv = "X-UA-Compatible"
    content    = "ie=edge"

  >

  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"

  >

  <link

    rel="preconnect"
    href="https://fonts.googleapis.com"

  >

  <link

      rel="preconnect"
      href="https://fonts.gstatic.com" crossorigin

  >

  <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@500&display=swap" rel="stylesheet">

  <link
    rel  = "stylesheet"
    href = "./styles/default.css"

  >

  <link
    rel  = "stylesheet"
    href = "./styles/breaks.css"

  >

</head>

~;

# ---   *   ---   *   ---

Readonly our $BODY=>q~

<body>

  <div class='ltop'>

    <h1>Dante Paola</h1>
    <h2>$:TITLE;></h2>

  </div>

<!-- ---   *   ---   *   ----->

  <div class='rtop'>

    <h3>$:CONTACT;></h3>

    <span class="ctct button"><a

      class = "fa fa-envelope"
      href  = "mailto:dantepaola25@gmail.com"

    ></a></span><span class="ctct button"><a

      href  = "https://github.com/Liebranca"
      class = "fa fa-github"

    ></a></span><span class="ctct button"><a

      href  = "
				https://www.linkedin.com
				/in/dante-paola-06701921b/

			"

      class="fa fa-linkedin"

    ></a></span>

  </div>

  <div class="ltop menu" id="menu-top">

     <span id='fetch_home'><i>$:HOME;></i></span
    ><span id='fetch_projx'><i>$:PROJX;></i></span
    ><span id='fetch_docs'><i>$:DOCS;></i></span
    ><span id='fetch_blog'><i>$:BLOG;></i></span>

  </div>

<!-- ---   *   ---   *   ----->

  <div id='fetpage'>
  </div>

  <script src="./data/content_$:LANG;>"></script>
  <script src="./src/about.js"></script>
  <script src="./src/menu.js"></script>

</body>

~;

# ---   *   ---   *   ---
# ^xlate

Readonly our $TAB=>{

  q[TITLE]=>{

    q[en]=>'Sofware Engineer',
    q[es]=>'Ingeniero de Sofware',

  },

  q[CONTACT]=>{
    q[en]=>'CONTACT',
    q[es]=>'CONTACTO',

  },

  q[HOME]=>{
    q[en]=>'Home',
    q[es]=>'Inicio',

  },

  q[PROJX]=>{
    q[en]=>'Projects',
    q[es]=>'Projectos',

  },

  q[DOCS]=>{
    q[en]=>'Documentation',
    q[es]=>'Documentación',

  },

  q[BLOG]=>{
    q[en]=>'Blog',
    q[es]=>'Blog',

  },

  q[LANGSEL]=>{
    q[en]=>'English',
    q[es]=>'Español',

  },

};

# ---   *   ---   *   ---
# get args

my ($Lang)=@ARGV;
$Lang=(! $Lang) ? 'en' : $Lang;

# ---   *   ---   *   ---
# put translations in body

my $Body=$BODY;
while($Body=~ m[$PESC_RE]) {

  my $key   = $1;
  my $value = ($key eq 'LANG')
    ? $Lang
    : $TAB->{$key}->{$Lang}
    ;

  $Body=~ s[$PESC_RE][$value];

};

# ---   *   ---   *   ---
# generate siggy

my $Note=Emit::Std::note($AUTHOR,q[<!--]);
$Note=~ s[(\n)][-->$1]sxmg;

# ---   *   ---   *   ---

my $Html=q[<html lang="].$Lang.q[">]."\n";
say $Html,$Note,$HEAD,$Body;

# ---   *   ---   *   ---
1; # ret
