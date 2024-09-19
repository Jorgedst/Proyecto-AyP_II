class JugadorXander extends Animacion
{
  int vidas, estado, timer;
  boolean enPlataforma, enPiso;
  PImage[] quietoDer, quietoIzq, saltoDer, dmgDer, die, saltodobleder, saltoIzq, dmgIzq, saltodobleizq;
  JugadorXander (PImage imagen) {
    super(imagen);
    vidas = 3;
    timer = 0;
    dir = derecha;
    enPlataforma = false;
    enPiso = false;
    //PImages con la cantidad de sprites de la animacion
    quietoDer = new PImage[2];
    quietoIzq = new PImage[2];
    moverDer = new PImage[4];
    saltoDer = new PImage[4];
    dmgDer = new PImage[2];
    saltodobleder = new PImage[4];
    die = new PImage[6];
    moverIzq = new PImage[4];
    saltoIzq = new PImage[4];
    dmgIzq = new PImage[2];
    saltodobleizq = new PImage[4];
    cargarAnimacion();
    actual= moverDer;
  }
  void cargarAnimacion() {
    timer = 0;
    //Animaciones para la derecha
    quietoDer[0]= personaje1[0];
    quietoDer[1]= personaje1[1];
    moverDer[0] = personaje1[6];
    moverDer[1] = personaje1[7];
    moverDer[2] = personaje1[8];
    moverDer[3] = personaje1[9];
    saltoDer[0]= personaje1[12];
    saltoDer[1]= personaje1[13];
    saltoDer[2]= personaje1[14];
    saltoDer[3]= personaje1[15];
    dmgDer[0]= personaje1[18];
    dmgDer[1]= personaje1[19];
    die[0]= personaje1 [24];
    die[1]= personaje1 [25];
    die[2]= personaje1 [26];
    die[3]= personaje1 [27];
    die[4]= personaje1 [28];
    die[5]= personaje1 [29];
    saltodobleder[0]= personaje1[24];
    saltodobleder[1]= personaje1[25];
    saltodobleder[2]= personaje1[26];
    saltodobleder[3]= personaje1[27];

    //Animaciones para la izquierda
    quietoIzq[0]= personaje1[36];
    quietoIzq[1]= personaje1[37];
    moverIzq[0] = personaje1[42];
    moverIzq[1] = personaje1[43];
    moverIzq[2] = personaje1[44];
    moverIzq[3] = personaje1[45];
    saltoIzq[0]= personaje1[48];
    saltoIzq[1]= personaje1[49];
    saltoIzq[2]= personaje1[50];
    saltoIzq[3]= personaje1[51];
    dmgIzq[0]= personaje1[54];
    dmgIzq[1]= personaje1[55];
    saltodobleizq[0]= personaje1[60];
    saltodobleizq[1]= personaje1[61];
    saltodobleizq[2]= personaje1[62];
    saltodobleizq[3]= personaje1[63];
  }
  @Override
    void actualizar() {
    enPlataforma= estaEnPlataforma(this, plataforma);
    enPiso = cambio.x == 0 && cambio.y == 0;
    super.actualizar();
  }
  @Override
    void seleccionarDireccion() {
    if (cambio.x > 0)
      dir= derecha;
    else if (cambio.x < 0)
      dir = izquierda;
  }
  @Override
    void seleccionarImagenActual() {
    if (swdaño) {
        if (dir == derecha) {
            actual = dmgDer;
            swdaño= false;
        } else if (dir == izquierda) {
            actual = dmgIzq;
            swdaño= false;
        }
    } else {
        if (dir == derecha) {
            if (enPiso) {
                actual = quietoDer;
            } else if (!enPlataforma) {
                actual = saltoDer;
            } else {
                actual = moverDer;
            }
        } else if (dir == izquierda) {
            if (enPiso) {
                actual = quietoIzq;
            } else if (!enPlataforma) {
                actual = saltoIzq;
            } else {
                actual = moverIzq;
            }
        }
    }
  }
}
