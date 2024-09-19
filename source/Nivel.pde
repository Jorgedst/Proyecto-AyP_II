class Nivel {
  Fondo lv1;
  PImage bgFondo;
  int mapa;
  Nivel() {
    lv1 = new Fondo("map0.csv", "Tiles0x32.png", 32);
  }
  void mostrar() {
    lv1.mostrar();
  }
  //Metodo para reiniciar todo cuando pierde el jugador
  void resetjuego() {
    lvl0= true;
    lvl1= false;
    lvl2= false;
    lvloculto = false;
    musica[2].rewind();
    musica[2].unmute();
    musica[2].play(1);
    musica[3].mute();
    musica[9].mute();
    jugxander.vidas =3;
    //Para pruebas *6700 * 70
    info.puntaje= 0;
    jugxander.center.x = 70;
    jugxander.center.y = 200;
    vistaP_x=0;
    
  }
  void cambiarNivel0() {
    scenecambiolvl1= true;
    musica[8].pause();
    musica[5].rewind();
    musica[5].unmute();
    musica[5].play();
    musica[6].mute();
    musica[7].mute();
    lvl0=true;
    lvl1= false;
    lvl2= false;
    plataforma.removeAll(plataforma);
    coin.removeAll(coin);
    lava.removeAll(lava);
    enemigo.removeAll(enemigo);
    jugxander.vidas =3;
    //Para pruebas *6700 * 70
    info.puntaje= 0;
    jugxander.center.x =70;
    jugxander.center.y = 200;
    vistaP_x=0;
    lv1 = new Fondo("map0.csv", "Tiles0x32.png", 32);
  }
  void cambiarNivel1() {
    musica[5].mute();
    musica[6].rewind();
    musica[6].unmute();
    musica[6].play();
    lvl1= true;
    lvl0= false;
    lvl2= false;
    plataforma.removeAll(plataforma);
    coin.removeAll(coin);
    lava.removeAll(lava);
    enemigo.removeAll(enemigo);
    jugxander.vidas =3;
    //Para pruebas *6700 * 70
    jugxander.center.x = 70;
    jugxander.center.y = 200;
    vistaP_x=0;
    lv1 = new Fondo("map1.csv", "Tiles1x32.png", 32);
  }
  void cambiarNivel2() {
    der_margen= 400;

    if (lvloculto) {
      jugxander.center.x =6510;
      jugxander.center.y = 2;
    } else {
      musica[6].mute();
      musica[7].rewind();
      musica[7].unmute();
      musica[7].play();
      lvl2=true;
      lvl0= false;
      lvl1= false;
      plataforma.removeAll(plataforma);
      coin.removeAll(coin);
      lava.removeAll(lava);
      enemigo.removeAll(enemigo);
      jugxander.vidas =3;
      jugxander.center.x =70;
      jugxander.center.y = 200;
    }
    vistaP_x=0;
    lv1 = new Fondo("map2.csv", "Tiles2x32.png", 32);
  }
  void cambiarNiveloculto() {
    der_margen=0;
    lvl2=false;
    lvl0= false;
    lvl1= false;
    plataforma.removeAll(plataforma);
    coin.removeAll(coin);
    lava.removeAll(lava);
    enemigo.removeAll(enemigo);
    jugxander.vidas =3;
    jugxander.center.x =60;
    jugxander.center.y = 200;
    vistaP_x=0;
    lv1 = new Fondo("mapoculto.csv", "Tiles2x32.png", 32);
  }
  
}
