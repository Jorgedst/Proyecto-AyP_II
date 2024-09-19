import ddf.minim.*;
Minim minim;
AudioPlayer[] musica;

//Libreria de gifs animados
import gifAnimation.*;
//Creacion de la variable menugif para la animacion de entrada.
Gif menugif, studios, portalx, mmnopressed, mmstarthover, mmcontrolhover, mmcredithover, creditmenu, creditmenubackhover, controlmenu, controlmenubackhover,
  diedscreen, winscreen, level1transition, level2transition, level3transition, finaleveltransition;
final static int normal=0;
final static int derecha =1;
final static int izquierda =2;
float der_margen = 400;
final static float izq_margen = 350;
final static float ver_margen = 40;
final static float gravedad = 0.6;
final static float salto = 14;
final static float saltodoble = 9;
float vel= 5;
final static float size_sprite = 32;
float vistaP_x = 0, posmouseX;
float vistaP_y = 0, posmouseY;
boolean menu= true, juego= false, doblesalto= false,
  lvl0= true, lvl1= false, lvl2= false, lvloculto= false, lvlzombies= false,
  escenastart= false, escenastudios=true, escenamainmenu= false, escenacontrols= false,
  escenacredits= false, escenadied= false, escenawin= false, stopwinscreen=false, scenecambiolvl1= true, scenecambiolvl2= false, scenecambiolvl3=false,
  scenecambiolvlfinal= false, swdaño, sceneselectmode= false;
PImage[] personaje1, collected;
PImage cursornormal, cursorhover, youdiedscreen, dscreenexithov, dscreenreshov, selectmode, normalmodehover,smbackhover;
ArrayList<Sprite> plataforma, coin, lava, enemigo;
JugadorXander jugxander;
Informacion info;
Nivel nivel;
Transicion shift;
ArrayList <Recolectar> juntar;


void setup() {
  size (800, 511);
  imageMode(CENTER);
  minim = new Minim(this);
  musica = new AudioPlayer[10];
  musica[0]= minim.loadFile("coinsound.mp3");
  musica[1]= minim.loadFile("Jumpsound.mp3");
  musica[2]= minim.loadFile("Musica16bits.mp3");
  musica[3]= minim.loadFile("winmusic.mp3");
  musica[4]= minim.loadFile("damagesound.mp3");
  musica[5]= minim.loadFile("Lvl1soundtrack.mp3");
  musica[6]= minim.loadFile("Lvl2soundtrack.mp3");
  musica[7]= minim.loadFile("Lvl3soundtrack.mp3");
  musica[8]= minim.loadFile("Diemusic.mp3");
  musica[9]= minim.loadFile("easteregg.mp3");
  surface.setTitle("ChronoLeap");
  cursorhover = loadImage("customcursorhover.png");
  cursornormal = loadImage("customcursor.png");
  cursor(cursornormal);
  dscreenexithov = loadImage("youdiedscreenexithover.png");
  dscreenreshov = loadImage("youdiedscreenrestarthover.png");
  diedscreen= new Gif (this, "youdiedscreen.gif");
  diedscreen.play();
  winscreen= new Gif (this, "WinScreen.gif");
  menugif= new Gif (this, "startgif.gif");
  menugif.loop();
  studios= new Gif (this, "studiosgif.gif");
  studios.play();
  portalx= new Gif (this, "portalx.gif");
  portalx.loop();
  mmstarthover= new Gif (this, "mainmenustarthover.gif");
  mmnopressed= new Gif (this, "mainmenunothingpressed.gif");
  mmcontrolhover= new Gif(this, "mainmenuncontrolhover.gif");
  mmcredithover= new Gif(this, "mainmenucredithover.gif");
  creditmenu = new Gif(this, "Creditsmenu.gif");
  creditmenu.loop();
  creditmenubackhover = new Gif(this, "Creditsmenubackhover.gif");
  creditmenubackhover.loop();
  controlmenu = new Gif(this, "controlmenu.gif");
  controlmenu.loop();
  controlmenubackhover = new Gif(this, "controlmenubackhover.gif");
  controlmenubackhover.loop();
  selectmode = loadImage("SelectMode.png");
  normalmodehover = loadImage("SelectModeNormalhover.png");
  smbackhover = loadImage("SelectModeBackHover.png");
  

  level1transition = new Gif(this, "level1transition.gif");
  level2transition = new Gif(this, "level2transition.gif");
  finaleveltransition = new Gif(this, "finaleveltransition.gif");
  personaje1 = new LeerArchivo(6, 11, "xanderspritesheetcolisionx64.png").getHoja();
  collected = new LeerArchivo(5, 1, "coincollect.png").getHoja();
  juntar = new ArrayList<Recolectar>();
  jugxander = new JugadorXander(personaje1[0]);
  info = new Informacion();
  //*6700 Para probar el siguiente nivel * 70 posicion default
  jugxander.center.x =70;
  jugxander.center.y = 200;
  nivel = new Nivel();
  shift = new Transicion();
}


void draw() {
  background(#A0A0A0);
  if (!musica[2].isPlaying()) {
    musica[2].setGain(-2);//Bajar volumen
    musica[2].play(1);
  }
  frameRate(60);
  if (escenastudios) {
    //La animacion de JIS studios.
    image (studios, width/2, height/2);
    if (studios.currentFrame() == 36 ) {
      // La animación ha terminado
      println("La animación de studios ha terminado");
      studios.stop();
      escenastudios= false;
      escenastart= true;
    }
  }
  //Una vez terminada la animacion de studios se reproduce la animacion start
  if (escenastart) {
    image (menugif, width/2, height/2);
  } else
    if (escenamainmenu ) {
      image (mmnopressed, width/2, height/2);
      posicionmouse();
    } else if (escenacredits) {
      image (creditmenu, width/2, height/2);
      posicionmouse();
    } else if (escenacontrols) {
      image (controlmenu, width/2, height/2);
      posicionmouse();
    }
  if (sceneselectmode) {
    image (selectmode, width/2, height/2);
    posicionmouse();
  }
  if (escenastart == false && escenastudios == false && escenamainmenu == false && escenacredits== false &&  escenacontrols==false && juego==true || lvlzombies == true) {
    cursor(cursornormal);
    shift.mostrar();
    if (juego) {
      if (!shift.visible)
        jugar();
    }
  }
  //Cuando el jugador agota todas las vidas
  if (jugxander.vidas == 0) {
    musica[5].mute();
    musica[6].mute();
    musica[7].mute();

    if (!musica[8].isPlaying()) {
      musica[8].rewind();
      musica[8].play(1);
    }
    juego = false;
    image(diedscreen, width/2, height/2);
    escenadied = true;
    if (diedscreen.currentFrame()== 14 ) {
      diedscreen.stop();
    }
    posicionmouse();
  }
  //Final del juego
  if (lvl0 == false && lvl2==true && jugxander.center.x > 6725 && jugxander.center.y >= 330) {
    if (!musica[3].isPlaying()) {
      musica[7].mute();
      musica[3].rewind();
      musica[3].play(1);
    }
    //Easter egg, presiona la F al terminar el juego.(Rick Roll)
    if (keyPressed && key == 'f' ) {
      musica[3].mute();
      musica[9].rewind();
      musica[9].play();
    }
    escenawin = true;
    juego= false;
    if (stopwinscreen == false) {
      winscreen.play();
    }
    image(winscreen, width/2, height/2);
    if (winscreen.currentFrame()== 10 ) {
      winscreen.stop();
      stopwinscreen= true;
    }
    info.winscreendata();
    posicionmouse();
  }
}

void jugar() {
  if (estaEnPlataforma(jugxander, plataforma)) {
    doblesalto= false;
  }
  desplazarEscenario();
  nivel.mostrar();
  jugxander.mostrar();
  jugxander.actualizar();
  resolverColision(jugxander, plataforma);
  reset();
  for (Sprite l : lava) {
    l.mostrar();
    ((Animacion)l).actualizar();
  }
  int total = 0;
  for (Recolectar r : juntar) {
    r.mostrar();
    if (!r.estado)
      total++;
  }
  if (total == juntar.size())
    juntar.removeAll(juntar);
  info.mostrar();
  //Ubicaciones del portal
  if (lvl0) {
    if (scenecambiolvl1) {
      level1transition.play();
      image (level1transition, width/2, height/2);
      if (level1transition.currentFrame()==13) {
        scenecambiolvl1= false;
      }
    }
    image (portalx, 6740, 435);
  }
  if (lvl1) {
    image (portalx, 6740, 435);
  }
  if (lvl2) {
    image (portalx, 6740, 435);
  }
  if (lvloculto) {
    image (portalx, 728, 435);
  }

  //Imagen cuando cambia al nivel 2
  if (scenecambiolvl2) {
    level2transition.play();
    image (level2transition, width/2, height/2);
    if (level2transition.currentFrame()==13) {
      scenecambiolvl2= false;
    }
  }
  //Imagen cuando cambia al nivel final
  if (scenecambiolvlfinal) {
    finaleveltransition.play();
    image (finaleveltransition, width/2, height/2);
    if (finaleveltransition.currentFrame()==13) {
      scenecambiolvlfinal= false;
    }
  }
  //Cambio de nivel
  if (lvl0== true && jugxander.center.x > 6725 && jugxander.center.y >= 330 ) {
    lvl0= false;
    lvl1 = true;
    scenecambiolvl2= true;
    nivel.cambiarNivel1();
    //Cambio de nivel
  } else if (lvl0 == false && lvl1== true && (jugxander.center.x > 6725 && jugxander.center.y >= 330)) {
    lvl1=false;
    lvl2= true;
    scenecambiolvlfinal= true;
    nivel.cambiarNivel2();
    //Sala oculta
  } else if (lvl2==false && lvloculto== true && ((jugxander.center.x > 723 && jugxander.center.x < 749) && jugxander.center.y == 450)) {
    lvl2 = true;
    nivel.cambiarNivel2();
    lvloculto= false;
  }
  if (lvlzombies) {
  }
  System.out.println("Ubicacion X: "+jugxander.center.x);
  System.out.println("Ubicacion Y: "+jugxander.center.y);
}

//Metodo para desplazar el escenario
void desplazarEscenario() {
  float der_dimension = vistaP_x + width - der_margen;
  if (jugxander.getRight() > der_dimension) {
    if (vistaP_x < 6000)
      vistaP_x += jugxander.getRight()-der_dimension;
  }
  float izq_dimension = vistaP_x + izq_margen;
  if (jugxander.getLeft()< izq_dimension) {
    if (vistaP_x > 0)
      vistaP_x -= izq_dimension -jugxander.getLeft();
  }
  translate(-vistaP_x, -vistaP_y);
}

//Sistema de colisiones
boolean tocado(Sprite s1, Sprite s2) {
  boolean tocarX = s1.getRight()<= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean tocarY = s1.getBottom()<= s2.getTop()|| s1.getTop() >= s2.getBottom();
  if (tocarX || tocarY)
    return false;
  else return true;
}
ArrayList<Sprite> tocandoLista(Sprite s, ArrayList<Sprite> lista) {
  ArrayList <Sprite> listaTocada = new ArrayList<Sprite>();
  for (Sprite p : lista) {
    if (tocado(s, p))
      listaTocada.add(p);
  }
  return listaTocada;
}

void resolverColision (Sprite s, ArrayList<Sprite> lista ) {
  s.cambio.y += gravedad;
  s.center.y += s.cambio.y;
  ArrayList<Sprite> colLista = tocandoLista(s, lista);
  if (colLista.size()>0) {
    Sprite colision = colLista.get(0);
    if (s.cambio.y >0)
      s.setBottom(colision.getTop());

    else if (s.cambio.y <0)
      s.setTop(colision.getBottom());
    s.cambio.y = 0;
  }
  s.center.x += s.cambio.x;
  colLista = tocandoLista(s, lista);
  //Bug de colision (Cheat) cambiar el > por un <.
  if (colLista.size()>0) {
    Sprite colision = colLista.get(0);
    if (s.cambio.x > 0)
      s.setRight(colision.getLeft());
    else if (s.cambio.x < 0)
      s.setLeft(colision.getRight());
    s.cambio.x=0;
    if (s.tipo > 0)
      ((Enemigo)s).invertir();
  }
}

boolean estaEnPlataforma (Sprite s, ArrayList<Sprite> pared) {
  s.center.y += 5;
  ArrayList<Sprite> colLista = tocandoLista(s, pared);
  s.center.y -= 5;
  if (colLista.size() > 0)
    return true;
  else
    return false;
}

void keyPressed() {
  if (key == 'w' && estaEnPlataforma(jugxander, plataforma)) {
    musica[1].setGain(-5);
    musica[1].play(400);

    jugxander.cambio.y = -salto;
  } else if (key == 'w' && !(estaEnPlataforma(jugxander, plataforma)) && doblesalto==false) {
    musica[1].setGain(-5);
    musica[1].play(500);

    jugxander.cambio.y = -saltodoble;
    doblesalto= true;
  } else if (key == 'd') {
    jugxander.cambio.x = vel;
  } else if (key == 'a')
    jugxander.cambio.x= -vel;

  if (key == ENTER) {
    //Si esta en el menu y presiona enter, inicia el juego.
    if (escenastart==true ) {
      escenastart = false;
      escenamainmenu = true;
    }
  }
}
void keyReleased() {
  if (key == 'd')
    jugxander.cambio.x = 0;

  else if (key == 'a')
    jugxander.cambio.x = 0;
  else if (key == 'w')
    jugxander.cambio.y= 0;
  //Volar(Cheat)
  /*jugxander.cambio.y= -9;*/
}
void mouseClicked() {
  //Si la persona clickea Start game
  if (escenamainmenu == true && posmouseY >175 && posmouseY <227 && posmouseX > 45 && posmouseX< 322) {
    escenamainmenu= false;
    sceneselectmode= true;
    //Si la persona presiona creditos
  } else if (escenamainmenu == true && posmouseY >336 && posmouseY <371 && posmouseX > 50 && posmouseX< 209) {
    escenamainmenu = false;
    escenacredits= true;
    //Si la persona presiona controls
  } else if (escenamainmenu== true && posmouseY >257 && posmouseY <292 && posmouseX > 59 && posmouseX< 250) {
    escenamainmenu=false;
    escenacontrols= true;
  }
  //Cuando la persona esta en el menu de creditos y presiona back
  if (escenacredits== true && posmouseY >455 && posmouseY <481 && posmouseX > 68 && posmouseX< 151) {
    escenamainmenu = true;
    escenacredits= false;
  }
  //Cuando la persona esta en el menu de controls y presiona back
  if (escenacontrols== true && posmouseY >455 && posmouseY <480 && posmouseX > 67 && posmouseX< 164) {
    escenamainmenu= true;
    escenacontrols= false;
  }
  //Cuando la persona esta en el menu de died y presiona exit
  if (escenadied==true && posmouseY >385 && posmouseY <420 && posmouseX > 347 && posmouseX< 440) {
    exit();
  }
  //Cuando la persona esta en el menu de died y presiona restart
  if (escenadied==true && posmouseY >314 && posmouseY <351 && posmouseX > 300 && posmouseX< 480) {
    reset();
    escenadied=false;
  }
  //Menu select mode y presiona normal
  if (sceneselectmode== true && posmouseY >240 && posmouseY <292 && posmouseX > 55 && posmouseX< 298 ) {
    musica[2].mute();
    musica[5].play(1);
    sceneselectmode= false;
    nivel.cambiarNivel0();
    juego = true;
  }
  //Menu select mode y presiona back
  if (sceneselectmode==true && posmouseY >473 && posmouseY <496 && posmouseX > 62 && posmouseX< 134) {
    sceneselectmode = false;
    escenamainmenu = true;
  }
  //Win screen y presiona main menu
  if (escenawin==true && posmouseY >440 && posmouseY <471 && posmouseX > 46 && posmouseX< 253) {
    escenawin= false;
    escenamainmenu= true;
    nivel.resetjuego();
  }
}
void reset() {
  if (escenadied==true || escenawin) {
    juego=true;
    vistaP_x =0;
    vistaP_y = 0;
    jugxander.vidas = 3;
    info.puntaje= 0;
    if (lvl0 || lvl1 || lvl2) {
      nivel.cambiarNivel0();
    }
  }
  //Sala oculta en el ultimo nivel
  if (jugxander.center.y > height && lvl2== true && (jugxander.center.x >= 6276 && jugxander.center.x <= 6376)) {
    lvl2 = false;
    lvloculto= true;
    nivel.cambiarNiveloculto();
  } else if (jugxander.center.y > height) {
    musica[4].play(40);
    shift.activar();
    jugxander.center.y = 200;
    jugxander.center.x= 80;
    vistaP_x =0;
    vistaP_y = 0;
    jugxander.vidas--;
  }


  //Algunas formas de perder vida en el nivel 2.
  if (lvl2 == true && jugxander.center.y== 226 && jugxander.center.x> 1171 && jugxander.center.x <1389 ) {
    musica[4].play(1);
    shift.activar();
    jugxander.center.y = 200;
    jugxander.center.x= 80;
    vistaP_x =0;
    vistaP_y = 0;
    jugxander.vidas--;
  }
  //Algunas formas de perder vida en el nivel 2
  if (lvl2 == true && jugxander.center.y== 194) {
    if ((jugxander.center.x > 3411 && jugxander.center.x < 3437)|| (jugxander.center.x > 3507 && jugxander.center.x < 3533)||(jugxander.center.x > 3603 && jugxander.center.x < 3629)||
      (jugxander.center.x > 3699 && jugxander.center.x < 3725)|| (jugxander.center.x > 3795 && jugxander.center.x < 3821)|| (jugxander.center.x > 3923 && jugxander.center.x < 3449)) {
      musica[4].play(1);
      shift.activar();
      jugxander.center.y = 200;
      jugxander.center.x= 80;
      vistaP_x =0;
      vistaP_y = 0;
      jugxander.vidas--;
    }
  }
}

void posicionmouse() {
  if (escenamainmenu ==true || escenacredits== true || escenacontrols==true|| escenadied==true || sceneselectmode== true|| escenawin== true) {
    posmouseX = mouseX ;
    posmouseY = mouseY;
    System.out.println ("Posicion mouse x : "+posmouseX);
    System.out.println ("Posicion mouse Y : "+posmouseY);
  }
  //Si el mouse esta sobre el menu - start game.
  if (escenamainmenu== true && posmouseY >175 && posmouseY <227 && posmouseX > 45 && posmouseX< 322) {
    image (mmstarthover, width/2, height/2);
    cursor(cursorhover);
    //Si el mouse esta sobre el menu - controles
  } else if (escenamainmenu== true && posmouseY >257 && posmouseY <292 && posmouseX > 59 && posmouseX< 250) {
    image (mmcontrolhover, width/2, height/2);
    cursor(cursorhover);
    //Si el mouse esta sobre el menu - creditos
  } else if (escenamainmenu== true && posmouseY >336 && posmouseY <371 && posmouseX > 50 && posmouseX< 209) {
    image (mmcredithover, width/2, height/2);
    cursor(cursorhover);
    //Si el mouse esta en el menu creditos - back
  } else if (escenacredits== true && posmouseY >455 && posmouseY <481 && posmouseX > 68 && posmouseX< 151) {
    image(creditmenubackhover, width/2, height/2);
    cursor(cursorhover);
    //Si el mouse esta en el menu controls - back
  } else if (escenacontrols== true && posmouseY >455 && posmouseY <480 && posmouseX > 67 && posmouseX< 164) {
    image(controlmenubackhover, width/2, height/2);
    cursor(cursorhover);
    //Si el mouse esta sobre el menu died - exit
  } else if (escenadied==true && posmouseY >385 && posmouseY <420 && posmouseX > 347 && posmouseX< 440) {
    image(dscreenexithov, width/2, height/2);
    cursor(cursorhover);
    //Si el mouse esta sobre el menu died - restart
  } else if (escenadied==true && posmouseY >314 && posmouseY <351 && posmouseX > 300 && posmouseX< 480) {
    image(dscreenreshov, width/2, height/2);
    cursor(cursorhover);
    //Si el mouse esta en el menu select mode - Normal
  } else if (sceneselectmode==true && posmouseY >240 && posmouseY <292 && posmouseX > 55 && posmouseX< 298) {
    image(normalmodehover, width/2, height/2);
    cursor(cursorhover);
    //Si el mouse esta en el menu select mode - Back...
  } else if (sceneselectmode==true && posmouseY >473 && posmouseY <496 && posmouseX > 62 && posmouseX< 134) {
    image (smbackhover, width/2, height/2);
    cursor(cursorhover);
    //si el mouse esta en win screen y presiona main menu
  } else if (escenawin==true && posmouseY >440 && posmouseY <471 && posmouseX > 46 && posmouseX< 253) {
    cursor(cursorhover);
  } else {
    cursor(cursornormal);
  }
}
