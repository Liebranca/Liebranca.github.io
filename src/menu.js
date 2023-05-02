// ---   *   ---   *   ---

const menus=[
  document.getElementById('menu-top')

];

const fetpage=document.getElementById('fetpage');


// ---   *   ---   *   ---

function langsel_show() {

  let dst=document.getElementsByClassName(
    "langsel-ct"

  )[0];

  dst.style.display=(dst.style.display == "none")
    ? "block"
    : "none"
    ;

};

document.getElementsByClassName(
  "langsel"

)[0].addEventListener('click',langsel_show);

// ---   *   ---   *   ---

document.getElementById(
  'en-langsel'

).addEventListener('click',function () {
  lang_swap('en');

});

document.getElementById(
  'es-langsel'

).addEventListener('click',function () {
  lang_swap('es');

});;

// ---   *   ---   *   ---

let Blocking  = [false,false];

let BST_Fade  = 0;
let BST_Fetch = 1;

let Lang_Pref = Ct_Lang;

// ---   *   ---   *   ---

function menu_init(m) {

  let ch=m.children;

  m.STX24={
    selected: 0,

  };

  for(let i=0;i<ch.length;i++) {

    let e=ch[i];

    e.STX24={
      selected: i==m.STX24.selected,

    };

    e.onclick=function (x) {
      if(! Blocking[BST_Fetch]) {
        menu_select(m,i);

      };

    };

  };

};

// ---   *   ---   *   ---

function menu_deselect(m) {
  let idex = m.STX24.selected;
  let ch   = m.children;
  let e    = ch[idex];

  e.STX24.selected=false;
  menu_e_set_bkg(e,'#101020');

};

function menu_select(m,i) {

  let ch = m.children;
  let e  = ch[i];

  menu_deselect(m);

  m.STX24.selected=i;
  e.STX24.selected=true;

  menu_e_set_bkg(e,'#202040');

  menu_e_fetch(e);
  save_state();

};

// ---   *   ---   *   ---

function page_fade(e,out=false,ival=24) {

  let step  = 1.0/ival;
  let bound = (out) ? step : 1.0-step;

  let xp    = (out) ? 1.0 : 0.0;
  let goal  = (out) ? 0.0 : 1.0;

  step      = (out) ? -step : step;

  Blocking[BST_Fade]=true;

  let fade  = setInterval(function () {

    if (

       ! (xp < 0)
    && ! (xp > 1)

    && xp != bound

    ) {
      xp+=step;

    } else {
      xp=goal;
      Blocking[BST_Fade]=false;

      clearInterval(fade);

    };

    e.style.opacity=xp;

  },ival);

};

// ---   *   ---   *   ---

function blocking_req(state,fn) {

  let fn_wait=setInterval(function () {

    if(! Blocking[state]) {
      clearInterval(fn_wait);
      fn();

    };

  },60);

};

// ---   *   ---   *   ---

function menu_e_fetch(e) {

  let key  = e.id;
  let ct   = (fetch_tab[key] != null)
    ? fetch_tab[key]
    : fetch_tab['pbwo']
    ;

  ct=(! ct.length) ? fetch_tab['pbwo'] : ct;

  Blocking[BST_Fetch]=true;

  blocking_req(BST_Fade,function () {
    page_fade(fetpage,true,12);

  });

  blocking_req(BST_Fade,function () {
    fetpage.innerHTML=ct;

    about_run();
    page_fade(fetpage,false);

    Blocking[BST_Fetch] = false;

  });

};

// ---   *   ---   *   ---

function menu_e_set_bkg(e,col) {

  e.style.setProperty(
    '--STX24-background',col

  );

  e.children[0].style.setProperty(
    '--STX24-background',col

  );

};

// ---   *   ---   *   ---

function save_state() {

  let saved={
    Lang_Pref: Lang_Pref,

  };

  for(let i=0;i < menus.length;i++) {
    saved[i]=menus[i].STX24;

  };

  localStorage.setItem(
    'STX24',
    JSON.stringify(saved)

  );

};

// ---   *   ---   *   ---

function load_state() {

  return JSON.parse(
    window.localStorage.getItem('STX24')

  );

};

// ---   *   ---   *   ---

function lang_swap(key) {

  console.log(key);

  Lang_Pref=key;
  lang_detect();

};

// ---   *   ---   *   ---

function lang_detect() {

  if(Ct_Lang != Lang_Pref) {

    let prefs = navigator.languages;

    if(

      (  prefs[0].startsWith('es')
      && Ct_Lang != 'es')

    || Lang_Pref == 'es'

    ) {

      window.location.href="./index_es.html";

    } else if(

      (  prefs[0].startsWith('en')
      && Ct_Lang != 'en')

    || Lang_Pref == 'en'

    ) {

      window.location.href="./index.html";

    };

  };

};

// ---   *   ---   *   ---

if(window.localStorage.STX24 == null) {

  for(let i=0;i < menus.length;i++) {
    menu_init(menus[i]);
    menu_select(menus[i],0);

  };

  save_state();

} else {

  let saved=load_state();

  for(let i=0;i<menus.length;i++) {
    menu_init(menus[i]);
    menu_select(menus[i],saved[i].selected);

  };

};

lang_detect();

// ---   *   ---   *   ---
