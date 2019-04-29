PGraphics pg,pg1,pg2;
PImage img,imgO,imgG, imgC;
void setup() {
  size(1400, 800); 
  img = loadImage("carro.jpg");
  pg = createGraphics(img.width, img.height);
  pg1 = createGraphics(img.width, img.height); 
  //pg = createGraphics(img.width, img.height);
//imgO =loadImage("img.jpg");
 // imgG =loadImage("paisaje.jpg");
  // gScale(imgO);
  // conv(imgG);
} 

float[][]matrix = new float[3][3];

void draw() {
 
  
  pg.beginDraw();  
  pg.image(img, 0, 0); 
  pg.endDraw();
  image(pg, 20, 20, 600,400);  
  gris(); 
 
  
  float[][]mat = {{0,-1,0}, // SharpenKernel
                  {-1,5,-1},
                  {0,-1,0}};
  conv(mat, 20,440, 400, 310);

 
  float[][]mat1 = {{0.0625,0.125,0.0625}, //Blur Kernel
                    {0.125,0.25,0.125},
                    {0.0625,0.125,0.0625}};
                    
  conv(mat1, 440, 440, 400, 310);
 
  float[][]mat2 = {{-1,-1,-1}, //Outline kernel
                    {-1,8,-1},
                    {-1,-1,-1}};
  
  conv(mat2, 860, 440, 400, 310);

     
}

void gris(){  
  pg1.beginDraw();    
  int dimension = pg1.width * pg1.height;
  pg1.loadPixels();
  for (int i = 0; i < dimension; i++) {
    pg1.pixels[i] = color((red(pg.pixels[i])+blue(pg.pixels[i])+green(pg.pixels[i]))/3);
  }
  pg1.updatePixels();
  pg1.endDraw();
  image(pg1, 640,20, 600, 400);
}

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
