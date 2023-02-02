// ---   *   ---   *   ---

const menus=[
  document.getElementById('menu-top')

];

const fetpage=document.getElementById('fetpage');

const fetch_tab={

  fetch_home: ct_home,
  fetch_about: ct_about,

};

// ---   *   ---   *   ---

let Blocking  = [false,false];

let BST_Fade  = 0;
let BST_Fetch = 1;

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
      if(!Blocking[BST_Fetch]) {
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

       !(xp < 0)
    && !(xp > 1)

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

    if(!Blocking[state]) {
      clearInterval(fn_wait);
      fn();

    };

  },60);

};

// ---   *   ---   *   ---

function menu_e_fetch(e) {

  let key  = e.id;

  if(fetch_tab[key] != null) {

    Blocking[BST_Fetch]=true;

    blocking_req(BST_Fade,function () {
      page_fade(fetpage,true,12);

    });

    blocking_req(BST_Fade,function () {
      fetpage.innerHTML=fetch_tab[key];
      page_fade(fetpage,false);

      Blocking[BST_Fetch] = false;

    });

  };

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

  let saved={};

  for(let i=0;i<menus.length;i++) {
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

if(window.localStorage.STX24 == null) {

  for(let i=0;i<menus.length;i++) {
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

// ---   *   ---   *   ---
