PImage img;
PImage img1;
PImage img2;
PImage img3;

PImage noisy;
PImage bMap;

int[] vectorNX;
int[] vectorNY;
void setup (){
  
  img= loadImage("imagen.png");
  img1= loadImage("imagen.png");
  
 // img2= loadImage("imagen1.png");
  //img3= loadImage("imagen1.png");
  
  size (800, 650);
  image(img1,0,0);

  vectorNX = new int [img.pixels.length];
  vectorNY = new int [img.pixels.length];
  
  mapToVec();
  envMap = new float[255*255];
  calculateEnvMap();
  
}
void keyReleased(){
  if(key==' '){
    mode = 0;
  }else if (key=='v'){
   mode = 3; 
  }
}
void draw(){
  
  if(mode==0){
    background(0);
    
    PImage s = bumpMapper(mouseX,mouseY);
   // PImage t = bumpMapper(mouseX, mouseY);
    image(s,0,0);
  //  image(t, 735,0);
  }else if(mode==3){
    image(img1,0,0);
  }

}

float[] envMap;

int size = 60;  
int mode = 0;

boolean phong = false;
boolean perlin = false;

PImage createBumpM(){
 if (perlin == true){
   float noiseScale = 0.5;
   noisy = createImage(width, height, RGB);
   noisy.loadPixels();
   for(int i=0;++i<width;){
     for(int j=0;++j<height;){
       noisy.pixels[i+j*width] = color(255*noise(i*noiseScale,j*noiseScale));
      } 
     }
   noisy.updatePixels();
   return noisy;
 }else{
   return loadImage("imagen.png");
 }
}


void mapToVec(){
  bMap = createBumpM();
  bMap.loadPixels();
  for(int i=1;i<bMap.width-1;i++){
      for(int j=1;j<bMap.height-1;j++){
        vectorNX[i+bMap.width*j] = round((bMap.pixels[(i+1)+bMap.width*j] >> 16 & 0xFF) - (bMap.pixels[(i-1)+bMap.width*j]>> 16 & 0xFF));
        vectorNY[i+bMap.width*j] =  round((bMap.pixels[i+bMap.width*(j+1)] >> 16 & 0xFF) -  (bMap.pixels[i+bMap.width*(j-1)] >> 16 & 0xFF));
      }
  }
}

void calculateEnvMap(){
  for(int j=0;j<255;j++){
      for(int i=0;i<255;i++){
       float Nx = (i - 128)/128.0;
       float Ny = (j - 128)/128.0;
       float Nz = 1 - sqrt(Nx * Nx + Ny * Ny);
       if(Nz<0)
         Nz = 0;
       if(phong){
         envMap[i+255*j] = 0 + min(255-0,0);//Phong = ambient + dif*dot + dot^2*spec
       }else{
         envMap[i+255*j] = Nz*256; 
       }
       

      }
  }
}

PImage bumpMapper(int lightX,int lightY){
  PImage buffer = createImage(img.width, img.height, RGB);
  buffer.loadPixels();
  img.loadPixels();
  lightX +=128;
  lightY +=128;
  for(int i=0;i<img.width;i++){
    for(int j=0;j<img.height;j++){
      int nX = vectorNX[i+img.width*j];
      int nY = vectorNY[i+img.width*j];
      int lDistX = i-lightX;
      int lDistY = j-lightY;
      nX -= lDistX;
      nY -= lDistY;
      if(nX<0 || nX>=255)
        nX = 0;
      if(nY<0 || nY>=255)
        nY = 0;
       
        color imgColor = img.pixels[i+img.width*j];
        color nuColor = color(norm(envMap[nX+255*nY], 0, 255)*red(imgColor),norm(envMap[nX+255*nY], 0, 255)*green(imgColor),norm(envMap[nX+255*nY], 0, 255)*blue(imgColor));
      
        buffer.pixels[i+img.width*j] = nuColor;

    }
  }
  buffer.updatePixels();
  return buffer;
}
