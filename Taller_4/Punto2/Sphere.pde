class Sphere extends Node {
  float _r; // variable que contiene el radio de la esfera
  int _c; // variable que contiene el color de la esfera

  public Sphere(Scene scene, int c, float r) {
    super(scene);
    _c = c;
    _r = r;
  }

  public void graphics(PGraphics pg) {
    pg.pushStyle();
    pg.noStroke();
    pg.fill(_c); // se aplica el color
    pg.sphere(_r); // se crea la esfera con un tamaño dado por el radio 
    pg.popStyle();
  }
}
