import processing.video.*; 

PGraphics pg,pg1;
Movie movie;

void setup() {  
  //frameRate(30);
  size(1080, 550); 
  movie = new Movie(this, "homer.mp4");
  movie.loop();
  pg = createGraphics(320, 400);
  pg1 = createGraphics(320, 400); 
}

void draw() { 
  background(0);
  pg.beginDraw();  
  pg.image(movie, 0, 0); 
  pg.endDraw();
  image(pg, 20, 20, 320,400);  
  
  float[][]mat = {{0,-1,0}, // SharpenKernel
                  {-1,5,-1},
                  {0,-1,0}};
  conv(mat, 380,300, 320, 400);

 
  float[][]mat1 = {{0.0625,0.125,0.0625}, //Blur Kernel
                    {0.125,0.25,0.125},
                    {0.0625,0.125,0.0625}};
                    
  conv(mat1, 20, 300, 320, 400);
 
  float[][]mat2 = {{-1,-1,-1}, //Outline kernel
                    {-1,8,-1},
                    {-1,-1,-1}};
  
  conv(mat2, 740, 300, 320, 400);
  
  //Gray(movie, 20, 20);
  //Neg(movie, 20, 20);
  textSize(25);
  text("FPS: " + int(frameRate),700, 250);  
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

void Neg(Movie movie, int w, int h){
  image(movie, w, h, 320, 200);
  loadPixels();
  for (int i=0; i<(width*height); i++) {
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);
    pixels[i] = color(255-r, 255-g, 255-b);
  }
  updatePixels();
}

void Gray(Movie movie, int w, int h){
  image(movie, w, h, 320, 200);
  loadPixels();
  for (int i=0; i<(width*height); i++) {
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);
    float x = (r + g + b)/3;
    pixels[i] = color(x, x, x);
  }
  updatePixels();
}

void movieEvent(Movie movie) {  
  movie.read();
}
