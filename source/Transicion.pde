//Cuando muere el jugador
class Transicion{
  int tamanio;
  boolean visible;
  Transicion()
  {
    tamanio = 1;
    visible= false;
  }
  void activar(){
    tamanio = 1;
    visible = true;
  }
  boolean desactivado(){
    if(tamanio >=150){
      visible = false;
      return false;
    }else{
      return true;
    }
  }
  void dibujar(){
    fill(#030303,200);
    for(int y= 0; y< height+80;y+=80){
      for(int x = 0; x < width+80; x+=80){
        circle(x,y,tamanio);
      }
    }
  }
  void mostrar(){
    if(desactivado()){
      dibujar();
      tamanio+=5;
    }
  }
}
