class Recolectar {
  PVector center;
  PImage []img;
  int pos;
  boolean estado;
  int frameCounter = 0;
  int frameRate = 5; //Cambia de sprite cada 5 fotogramas
  Recolectar (float x, float y) {
    img = new PImage[5];
    center = new PVector (x, y);
    pos = 0;
    estado = true;
    img[0] = collected[0];
    img[1] = collected[1];
    img[2] = collected[2];
    img[3] = collected[3];
    img[4] = collected[4];
  }
  void mostrar() {
    if (estado) {
      frameCounter++;
      if(frameCounter >= frameRate){
        frameCounter = 0;
        pos++;
      }
      if (pos < 5)
        image (img[pos], center.x, center.y);
      if (pos> 4) {
        pos = 0;
        estado = false;
      }
    }
  }
}
