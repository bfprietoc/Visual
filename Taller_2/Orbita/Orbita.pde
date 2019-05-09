void setup(){
  size(600,600);
 ellipseMode(ROUND);
 noFill();
 smooth();
  
}

void mouseClicked() {
  if (b==0) {
    b=255;
  } else {
    b=0;
  }
}

int r = 250;
int n = 65;
int b =0;

void draw(){
  background(255);
  stroke(0);
  fill(200);
  float conteo = frameCount*0.01f;
  ellipse(width/2,height/2,r,r);
  translate(width/2,height/2);
  for (int i = 0; i<n; i++ ){
    float angle = conteo+i*0.1f;
    float x = cos(angle) * r;
    float y = sin(angle) * r/4;
  
  if (b==0 && y<=0){
    stroke(0);
    noFill();
    ellipse(x,y,40,40);
  }
  if (b!=0 && y>=0) {
    stroke(0);
    noFill();
    ellipse(x, y, 40, 40);
  }
  if (keyPressed == true) {
    stroke(0);
    noFill();
    ellipse(x, y, 40, 40);
    } 
  
  }
}
