class Lava extends Animacion
{
  Lava (PImage uno, PImage dos){
    super (uno);
    quieto = new PImage [2];
    quieto[0]= uno;
    quieto[1]= dos;
    actual = quieto;
  }
}
