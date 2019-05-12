PImage leon, raton;
PGraphics pg, pg1;
void setup(){
  pg=createGraphics(640,640);
  pg1=createGraphics(640,640);
  size(1285, 640);
  leon= loadImage("Leon.jpg");
  raton= loadImage("Raton.jpg");
}

void draw(){
  pg.beginDraw();
  pg.image(leon, 0, 0);
  pg.endDraw();
  image(pg, 0, 0, 640, 640);
  
  pg1.beginDraw();
  pg1.image(raton, 0, 0);
  pg1.translate(320,320);
  //pg1.rotate(PI);
  pg1.endDraw();
  image(pg1, 645, 0, 640, 640);
}
