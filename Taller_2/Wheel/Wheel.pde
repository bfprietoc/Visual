PGraphics pg;

int w=800;
int h=600;
float vel=50;
float mov;

void setup(){
  size(800,600);
  w=width;
  h=height;
  pg=createGraphics(w,h);
}

void draw (){
  pg.beginDraw();
  pg.translate(w/2,h/2);
  pg.background(0,0,0);
  pg.fill(255);
  pg.rotate(radians(mov));
  for (int i = 0; i<8; i++ ){
  pg.rotate((PI/4)*(i));
  pg.quad(-5,10,5,10,30,200,-30,200);
  }
  pg.endDraw();
  image(pg,0,0);
  mov = mov + vel;
  vel = vel + 0.1;
  
}
