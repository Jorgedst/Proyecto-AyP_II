class Informacion {
  PImage[] img, imgcoincount;
  int puntaje, segundos;
  PImage hp3, hp2, hp1;
  PFont fuente;

  Informacion() {
    hp3 = loadImage("3hp.png");
    hp2 = loadImage("2hp.png");
    hp1 = loadImage("1hp.png");
    fuente = createFont("Minecraft.ttf", 20);
    puntaje = 0;
    segundos= 0;
  }
  void mostrar() {
    imgcoincount = new LeerArchivo (1, 1, "coincount64.png").getHoja();
    if (lvl0 || lvl1 || lvl2 || lvloculto ) {
      if (jugxander.vidas==3) {
        image(hp3, vistaP_x+110, 65, 192, 192);
      } else if (jugxander.vidas == 2) {
        image(hp2, vistaP_x+110, 65, 192, 192);
      } else if (jugxander.vidas==1) {
        image(hp1, vistaP_x+110, 65, 192, 192);
      }
      fill(0);
      String txt = nf(puntaje, 2);
      textFont(fuente);
      text ("x"+txt, vistaP_x+78, 130);
      image (imgcoincount [jugxander.estado], vistaP_x+53, 125);
      
    }
  }
  void sumar() {
    puntaje++;
    if (puntaje % 10 == 0 && jugxander.vidas <3) {
      jugxander.vidas++;
    }
  }
  void winscreendata() {

    fill(255);
    textFont(fuente);
    textSize(60);
    text("Score: "+puntaje, 270, 251);
    textSize(90);
    text("¡YOU WIN!", 180, 150);
  }
}
