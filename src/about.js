// ---   *   ---   *   ---
// ABOUT
// Calculates data bound
// by the passage of time
//
// LIBRE SOFTWARE
// Licensed under GNU GPL3
// be a bro and inherit
//
// CONTRIBUTORS
// lyeb,

// ---   *   ---   *   ---

function lyeb_age() {

  let bd    = new Date("02/25/1994");
  let today = new Date();

  let age   =
    today.getFullYear()
  - bd.getFullYear()
  ;

  let dst=document.getElementById('lyeb-age');

  if(dst != null) {
    dst.innerHTML=age;

  };

};

// ---   *   ---   *   ---

function about_run() {
  lyeb_age();

};

// ---   *   ---   *   ---
