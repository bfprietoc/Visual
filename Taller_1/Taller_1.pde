PGraphics pg1,pg2;
PImage imgO, imgG, imgC;

void setup() {
  size (1800,1000);
  
  imgO = loadImage("paisaje.jpg");
  image(imgO, 20,20,600,400);
  gScale(imgO);
  pg1 = createGraphics(imgO.width, imgO.height);
  conv(imgO);
  
  
} 
  void gScale(PImage img){
    int dimension = img.width*img.height;
    for (int i = 0 ; i<dimension; i++){
       float r = red(img.pixels[i]);
       float g = green(img.pixels[i]);
       float b = blue(img.pixels[i]);
       float gray = (r+g+b)/3;
       img.pixels[i] = color(gray);
    }
    img.updatePixels();
    image(img,640,20,600,400);
    
  }


// The convolution matrix for a "sharpen" effect stored as a 3 x 3 two-dimensional array.
float[][] kernel = { { 1, 2, 1 } , 
                     { 0,0, 0 } ,
                     { -1, -2, -1 } } ;
                     
                     //sharpenKernel
float[][] kernel1 = { { 0, -1, 0 } , 
                     { -1, 5, -1 } ,
                     { 0, -1, 0 } } ;
                     // blurKernel
float[][] kernel2 = { { 0.0625, 0.125, 0.0625 } , 
                     { 0.125, 0.25, 0.125 } ,
                     { 0.0625, 0.125, 0.0625 } } ;
                     
                     
                     
                     
                     
/*                     
void convo(PImage img){
  float val = 0.0;
  img.loadPixels();
  // Crea una imagen del mismo tamaño que la orioginal
  PImage edgeImg = createImage(img.width, img.height, RGB);
  for (int y = 1; y < img.height+1; y++) { 
    for (int x = 1; x < img.width+1; x++) { 
      float sum = 0.0; 
     
// Calcula el pixel adyacente
          int pos = (y)*width + (x);
// Image en escala de grises con los valores iguales de rgb
         
          sum += red(img.pixels[pos]) * kernel[y][x];
          
          edgeImg.pixels[y*img.width + x] = color(sum);
        }
      }
      edgeImg.updatePixels();
      image(img,20,440,600,400);
    }
  
 */ 
  
  
  

                     
                     
                     
                     

void conv(PImage img) {
    
  
  
  img.loadPixels();
  // Begin our loop for every pixel
  for (int x = 0; x < img.width; x++ ) {
    for (int y = 0; y < img.height; y++ ) {
      color c = convolution(x,y,kernel,3,img); 
      int loc = x + y*img.width;
      img.pixels[loc] = color(c);
    }
  }
  img.updatePixels();
  image(img,20,440,600,400);
  
  
}

color convolution(int x, int y, float[][] kernel, int kernelsize, PImage img) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = kernelsize / 2;
  
  // Loop through convolution matrix
  for (int i = 0; i < kernelsize; i++ ) {
    for (int j = 0; j < kernelsize; j++ ) {
      
      // What pixel are we testing
      int xloc = x + i-offset;
      int yloc = y + j-offset;
      int loc = xloc + img.width*yloc;
      
      // Make sure we haven't walked off the edge of the pixel array
      // It is often good when looking at neighboring pixels to make sure we have not gone off the edge of the pixel array by accident.
      loc = constrain(loc,0,img.pixels.length-1);
      
      // Calculate the convolution
      // We sum all the neighboring pixels multiplied by the values in the convolution matrix.
      rtotal += (red(img.pixels[loc]) * kernel[i][j]);
      gtotal += (green(img.pixels[loc]) * kernel[i][j]);
      btotal += (blue(img.pixels[loc]) * kernel[i][j]);
    }
  }
  
  // Make sure RGB is within range
  rtotal = constrain(rtotal,0,255);
  gtotal = constrain(gtotal,0,255);
  btotal = constrain(btotal,0,255);
  
  // Return the resulting color
  return color(rtotal,gtotal,btotal); 
}
