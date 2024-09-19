class Enemigo extends Animacion
{
  PImage[] enemigoslvl1, enemigoslvl2, enemigoslvl3,enemigOculto;
  int dir, clase, daño=10;
  Enemigo(PImage ene, int esUn)
  {
    super(ene);
    shift = new Transicion();
    if (lvl0) {
      tamanio.x = 84;
      tamanio.y = 54;
    } else if (lvl1) {
      tamanio.x = 50;
      tamanio.y = 64;
    }else if (lvl2){
      tamanio.x = 48;
      tamanio.y = 48;
    }else if (lvloculto){
      tamanio.x = 84;
      tamanio.y = 84;
    }

    tipo = 1;
    clase = esUn;
    dir = izquierda;
    if(lvloculto){
      cambio.x = -4;
    }else{
      cambio.x = -1;
    }
    enemigoslvl1 = new LeerArchivo(8, 3, "Enemigoslvl1_84x54.png").getHoja();
    enemigoslvl2 = new LeerArchivo(8, 3, "Enemyslvl2_64x50.png").getHoja();
    enemigoslvl3 = new LeerArchivo(8, 3, "Enemigoslvl3x48.png").getHoja();
    enemigOculto = new LeerArchivo(8,1, "hiddenenmy.png").getHoja();
    quieto = new PImage[1];
    quieto[0] = enemigoslvl1[0];
    if (lvl0) {
      if (clase == 1)//Velociraptor
      {
        moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverIzq[0] = enemigoslvl1[0];
        moverIzq[1] = enemigoslvl1[1];
        moverIzq[2] = enemigoslvl1[2];
        moverIzq[3] = enemigoslvl1[3];
        moverDer[0] = enemigoslvl1[4];
        moverDer[1] = enemigoslvl1[5];
        moverDer[2] = enemigoslvl1[6];
        moverDer[3] = enemigoslvl1[7];
      } else if (clase == 2)//Dinosaurio verde
      {
        moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverDer[0] = enemigoslvl1[12];
        moverDer[1] = enemigoslvl1[13];
        moverDer[2] = enemigoslvl1[14];
        moverDer[3] = enemigoslvl1[15];
        moverIzq[0] = enemigoslvl1[8];
        moverIzq[1] = enemigoslvl1[9];
        moverIzq[2] = enemigoslvl1[10];
        moverIzq[3] = enemigoslvl1[11];
      }
      actual = moverIzq;
    } else if (lvl1) {
      if (clase == 1)//Romano 1 amarillo
      {
        moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverIzq[0] = enemigoslvl2[0];
        moverIzq[1] = enemigoslvl2[1];
        moverIzq[2] = enemigoslvl2[2];
        moverIzq[3] = enemigoslvl2[3];
        moverDer[0] = enemigoslvl2[4];
        moverDer[1] = enemigoslvl2[5];
        moverDer[2] = enemigoslvl2[6];
        moverDer[3] = enemigoslvl2[7];
      } else if (clase == 2)//Romano 2 azul
      {
        moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverIzq[0] = enemigoslvl2[8];
        moverIzq[1] = enemigoslvl2[9];
        moverIzq[2] = enemigoslvl2[10];
        moverIzq[3] = enemigoslvl2[11];
        moverDer[0] = enemigoslvl2[12];
        moverDer[1] = enemigoslvl2[13];
        moverDer[2] = enemigoslvl2[14];
        moverDer[3] = enemigoslvl2[15];
      } else if (clase==3) // Romano con arco
      {
        moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverIzq[0] = enemigoslvl2[16];
        moverIzq[1] = enemigoslvl2[17];
        moverIzq[2] = enemigoslvl2[18];
        moverIzq[3] = enemigoslvl2[19];
        moverDer[0] = enemigoslvl2[20];
        moverDer[1] = enemigoslvl2[21];
        moverDer[2] = enemigoslvl2[22];
        moverDer[3] = enemigoslvl2[23];
      }
    } else if (lvl2) {
      if (clase == 1)//Soldado 1
      {
        moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverIzq[0] = enemigoslvl3[0];
        moverIzq[1] = enemigoslvl3[1];
        moverIzq[2] = enemigoslvl3[2];
        moverIzq[3] = enemigoslvl3[3];
        moverDer[0] = enemigoslvl3[4];
        moverDer[1] = enemigoslvl3[5];
        moverDer[2] = enemigoslvl3[6];
        moverDer[3] = enemigoslvl3[7];
      } else if (clase == 2)//Soldado 2
      {
        moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverIzq[0] = enemigoslvl3[8];
        moverIzq[1] = enemigoslvl3[9];
        moverIzq[2] = enemigoslvl3[10];
        moverIzq[3] = enemigoslvl3[11];
        moverDer[0] = enemigoslvl3[12];
        moverDer[1] = enemigoslvl3[13];
        moverDer[2] = enemigoslvl3[14];
        moverDer[3] = enemigoslvl3[15];
      } else if (clase==3) // Soldado 3 Juggernaut
      {
        moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverIzq[0] = enemigoslvl3[16];
        moverIzq[1] = enemigoslvl3[17];
        moverIzq[2] = enemigoslvl3[18];
        moverIzq[3] = enemigoslvl3[19];
        moverDer[0] = enemigoslvl3[20];
        moverDer[1] = enemigoslvl3[21];
        moverDer[2] = enemigoslvl3[22];
        moverDer[3] = enemigoslvl3[23];
      }
    }else if (lvloculto){
      moverDer = new PImage[4];
        moverIzq = new PImage[4];
        moverIzq[0] = enemigOculto[4];
        moverIzq[1] = enemigOculto[5];
        moverIzq[2] = enemigOculto[6];
        moverIzq[3] = enemigOculto[7];
        moverDer[0] = enemigOculto[0];
        moverDer[1] = enemigOculto[1];
        moverDer[2] = enemigOculto[2];
        moverDer[3] = enemigOculto[3];
    }
  }
  @Override
    void mover() {
    actualizar();
    resolverColision(this, plataforma);
    if (tocado(jugxander, this)) {
      swdaño = true;
      if (daño==10) {
        if ( num == 50 || num== 51 || num==52) {
          
          System.out.println("SwitchDañoEncolision"+swdaño);
          musica[4].play(1);
          jugxander.vidas--;
        }
        daño--;
      }
    } else {
      daño= 10;
    }
    //System.out.println("SwitchDaño"+swdaño);
  }
  void invertir()
  {
    if (dir == izquierda)
    {
      dir = derecha;
      if(lvloculto){
        cambio.x= 4;
      }else{
      cambio.x = 1.5;
      }
    } else if (dir == derecha)
    {
      dir = izquierda;
      if(lvloculto){
        cambio.x= -4;
      }else{
      cambio.x = -1.5;
      }
    }
  }
}
