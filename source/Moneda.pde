class Moneda extends Animacion{
  int tipo;
  Moneda (PImage img, int _tipo){
    super (img);
    tipo = _tipo;
    quieto = new LeerArchivo (4,1,"CoinRotation32.png").getHoja();
    actual = quieto;
  }
}
