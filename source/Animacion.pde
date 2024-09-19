//Extends para heredar todos los metodos de la clase sprite, sprite es la superclase
class Animacion extends Sprite {
  //Matriz que contiene a las imagenes
  PImage [] actual, quieto, moverIzq, moverDer;
  int dir, index, frame;
  int frameCounter = 0;
  int frameRate = 8; //Cambia de sprite cada 8 fotogramas
  Animacion (PImage img) {
    //Haciendo referencia al constructor de plataforma de la clase Sprite
    super(img, 0);
    dir = normal;
    index= 0;
    frame= 0;
  }
  void actualizar() {
    frameCounter++;
    if (frameCounter >= frameRate) {
      frameCounter= 0;
      seleccionarDireccion();
      seleccionarImagenActual();
      avanzaImagen();
    }
  }
  void seleccionarDireccion() {
    if (cambio.x > 0)
      dir= derecha;
    else if (cambio.x < 0)
      dir= izquierda;
    else
      dir = normal;
  }
  void seleccionarImagenActual() {
    if (dir == izquierda){
      actual = moverIzq;
    }
    else if (dir == derecha)
      actual = moverDer;
    else
      actual = quieto;
  }
  void avanzaImagen() {
    index++;
    if (index >= actual.length)
      index= 0;
    img = actual[index];
  }
}
