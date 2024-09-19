class Fondo {
  PImage mySprite[], FondoImagen;
  float sizeSprite;
  Fondo (String name, String tilemap, float size) {
    sizeSprite = size;
    mySprite =new LeerArchivo(4, 5, tilemap).getHoja();
    plataforma = new ArrayList<Sprite>();
    coin = new ArrayList<Sprite>();
    lava = new ArrayList <Sprite>();
    enemigo = new ArrayList<Sprite>();
    if (lvl0) {
      FondoImagen = loadImage("bg1.png");
      crearPlataforma(name);
    } else if (lvl1) {
      FondoImagen = loadImage("bg2.png");
      crearPlataforma(name);
    } else if (lvl2 || lvloculto) {
      FondoImagen = loadImage("bg3.png");
      crearPlataforma(name);
    }
  }
  void mostrar() {
    image(FondoImagen, vistaP_x+width/2, height/2+1);
    for (Sprite p : plataforma)
      p.mostrar();
    for (Sprite m : coin) {
      m.mostrar();
      ((Animacion)m).actualizar();
    }
    ArrayList<Sprite> recoleccion = tocandoLista(jugxander, coin);
    if (recoleccion.size() > 0) {
      for (Sprite r : recoleccion) {
        musica[0].setGain(-10);
        musica[0].play(50);
        juntar.add(new Recolectar(r.center.x, r.center.y));
        coin.remove(r);
        info.sumar();
      }
    }
    for (Sprite e : enemigo)
    {
      e.mostrar();
      e.mover();
    }
  }
  void crearPlataforma(String archivo) {
    String[] lineas = loadStrings(archivo);
    for (int row = 0; row < lineas.length; row++ ) {
      String[] valores = split(lineas[row], ";");
      for (int col=0; col < valores.length; col++) {
        int num= obtenerNum(valores[col]);
        if (num < 16) {
          Sprite s = new Sprite(mySprite[num], num);
          s.center.x = sizeSprite/2 + col*sizeSprite;
          s.center.y = sizeSprite/2 + row*sizeSprite;
          plataforma.add(s);
        } else if (num == 16) {
          Lava l = new Lava(mySprite[num], mySprite[num+1]);
          l.center.x = sizeSprite/2 + col*sizeSprite;
          l.center.y = sizeSprite/2 + row*sizeSprite;
          lava.add(l);
        } else if (num == 19) {
          Moneda c = new Moneda(mySprite[num], 0);
          c.center.x = sizeSprite/2 + col * sizeSprite;
          c.center.y = sizeSprite/2 + row * sizeSprite;
          coin.add(c);
        }
        //Añadiendo enemigos para todos los niveles
        if (num==50) { // Tipo 1 de enemigo
          Enemigo n = new Enemigo(mySprite[18], 1);
          n.center.x = sizeSprite/2 + col * sizeSprite;
          n.center.y = sizeSprite/2 + row * sizeSprite;
          n.tipo = 1;
          n.num = 50;
          enemigo.add(n);
        } else
          if (num == 51) { //Tipo 2 de enemigo
            Enemigo n = new Enemigo(mySprite[18], 2);
            n.center.x = sizeSprite/2 + col * sizeSprite;
            n.center.y = sizeSprite/2 + row * sizeSprite;
            n.tipo = 2;
            n.num = 51;
            enemigo.add(n);
          } else if (num==52) {//Tipo 3 de enemigo
            Enemigo n = new Enemigo(mySprite[18], 3);
            n.center.x = sizeSprite/2 + col * sizeSprite;
            n.center.y = sizeSprite/2 + row * sizeSprite;
            n.tipo = 3;
            n.num = 52;
            enemigo.add(n);
          }
      }
    }
  }



  int obtenerNum(String txt) {
    int num = 0;
    num = Integer.valueOf(txt);
    return num;
  }
}
