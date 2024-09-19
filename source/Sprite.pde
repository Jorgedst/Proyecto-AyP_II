class Sprite{
  PImage img;
  PVector center, cambio, tamanio;
  int tipo, num;
  Sprite (PImage archivo, int pared){
    img= archivo;
    tamanio= new PVector (img.width,img.height);
    center= new PVector (0,0);
    cambio= new PVector (0,0);
    tipo = 0;
    num= pared;
  }
 
  void mostrar(){
    image(img,center.x,center.y);
  }
  void mover(){
    center.x += cambio.x;
    center.y += cambio.y;
  }
  //
  void setLeft(float left){
    center.x = left + tamanio.x/2;
  }
  float getLeft(){
    return center.x - tamanio.x/2;
  }
  
  void setRight(Float right){
    center.x = right -tamanio.x/2; 
  }
  float getRight(){
   return center.x + tamanio.x/2; 
  }
  
  void setTop(float top){
    center.y = top + tamanio.y/2;
  }
  float getTop(){
    return center.y - tamanio.y/2;
  }
  
  void setBottom (float bottom){
    center.y = bottom - tamanio.y/2;
  }
  float getBottom(){
    return center.y + tamanio.y/2;
  }
}
