    
PImage img, ren;
float pos;
int b=0;

void setup()
{
  pos = 70;
  size(500,560);
  img = loadImage("oie_transparent.png"); 
  ren = loadImage("oie_transparent1.png"); 
  fill(0,250,0);
}

void draw()
{
  background(255);
  image(img, 20, 140, 330, 397);
  if(b==0){
    image(ren, 120, pos, 330, 397);  
    pos = pos-0.3;
    if(pos<62){
      pos = 70;
    }    
  }
  else{
  image(ren, 120, pos, 330, 397);  
    pos = pos+0.3;
    if(pos>70){
      pos = 62;
  } 
}
}

void mouseClicked() {
  if (b==0) {
    b=1;
  } else {
    b=0;
  }
}
