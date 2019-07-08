import processing.video.*; 

PGraphics pg,pg1;
Movie movie;


int maskSelected = 0;
boolean enabledMasks = false;

void setup() {  
  //frameRate(30);
  size(1200, 600); 
  movie = new Movie(this, "homer.mp4");
  //movie = new Movie(this, "paisaje.mp4");

  movie.loop();
  
  pg = createGraphics(480, 272);
  pg1 = createGraphics(480, 272); 
}




void draw() { 
  background(0);
  pg.beginDraw();  
  pg.image(movie, 0, 0); 
  pg.endDraw();
  //image(pg, 20, 20, 1500,500);  
  

  drawMasks();
  textSize(25);
  text("FPS: " + int(frameRate),700, 500);  
}

float[][]matrix = new float[3][3];






void conv(float[][]matriz, float xpos, float ypos,float xwidth, float yheight){  
  pg1.beginDraw();    
  pg1.loadPixels();
  int xstart = 0;
  int ystart = 0;
  int xend = pg.width;
  int yend = pg.height;
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++ ) {
      color c = conv(x, y, matriz, 3, pg);
      int loc = x + y*pg.width;
      pg1.pixels[loc] = c;
    }
  }
  pg1.updatePixels();
  pg1.endDraw();
  image(pg1,xpos,ypos,xwidth, yheight);
}                    
    

                     
color conv(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}

void drawMasks(){
  //Sharpen
  
  if(maskSelected == 0){
  image(pg, 20, 20, 1100,500);  
  }
  if(maskSelected == 1){
  float[][]mat2 = {{-1,-1,-1}, //Outline kernel
                    {-1,8,-1},
                    {-1,-1,-1}};
      conv(mat2, 20,20, 1100, 500);
  }
  
    //Gaussian Blur 3x3
    if(maskSelected == 2){
    float[][]mat1 = {{0.0625,0.125,0.0625}, //Blur Kernel
                    {0.125,0.25,0.125},
                    {0.0625,0.125,0.0625}};
       
      conv(mat1, 20,20, 1100, 500);
  }
   // SHARPEN DETECTION
    if(maskSelected == 3){
    float[][]mat2 = {{-1,-1,-1}, //Sharpen Kernel
                    {-1,9,-1},
                    {-1,-1,-1}};
       
      conv(mat2, 20,20, 1100, 500);
  }
  if(maskSelected == 4){
    float[][]mat3 = {{1,0,0}, //Motion Blur 
                    {0,1,0},
                    {0,0,1}};
       
    conv(mat3, 20,20, 1100, 500);
  }  
  
}

void keyPressed() {
  handleKeyPress(key);
}
void handleKeyPress(char pressed) { 
  if (pressed == 'm') {
    enabledMasks = !enabledMasks;

  }
  if (pressed == '1') {
    maskSelected = 1;
  }
  if (pressed == '2') {
    maskSelected = 2;
  }
    if (pressed == '3') {
    maskSelected = 3;
  }
  
  if (pressed == '4') {
    maskSelected = 4;
  }
}


void movieEvent(Movie movie) {  
  movie.read();
}
