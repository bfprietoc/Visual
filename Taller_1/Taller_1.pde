 
PGraphics pg, pg1, pg2;
PImage img;

int[] histogram;
int count, option = 0;
int start,end;

float[][]matrix = new float[3][3];

float[][]mat = {{0,-1,0}, // SharpenKernel
                {-1,5,-1},
                {0,-1,0}};

float[][]mat1 = {{0.0625,0.125,0.0625}, //Blur Kernel
                  {0.125,0.25,0.125},
                  {0.0625,0.125,0.0625}};
                  
 
float[][]mat2 = {{-1,-1,-1}, //Outline kernel
                  {-1,8,-1},
                  {-1,-1,-1}};



void setup() {
  size(1150, 500);
  img = loadImage("carro.jpg");
  pg = createGraphics(img.width, img.height);
  pg1 = createGraphics(img.width, img.height);
  pg2 = createGraphics(300, 200);
  histogram = makeHistogram(img);

  
}

void draw() {
  pg.beginDraw();  
  pg.image(img, 0, 0); 
  pg.endDraw();
  image(pg, 20, 20, 300,200);
  
  pg1.beginDraw();  
  pg1.image(img, 0, 0); 
  pg1.endDraw();
  image(pg1, 340, 230, 300,200);  
  pg2.beginDraw(); 
  //pg2.background(100);
  pg2.endDraw();
  image(pg2,20, 230, 300, 200);
  
  gris();
  drawHistogram(histogram);
  
  if(option == 1){
    conv(mat, 340,230, 300, 200);
  }
  else if(option == 2){
    conv(mat1, 340,230, 300, 200);
  }
  else if(option == 3){
    conv(mat2, 340,230, 300, 200);
  }
  else if(option == 4){
    segmentation(start,end);
  }
  buttons();

}



void buttons(){
   int w = 400, h = 50;
   fill(130);
   stroke(0);
   rect(680, 40, w , h ,10);
   fill(0);
   textSize(32);
   text("SharpenKernel",680+80,80);
   
   fill(130);
   stroke(0);
   rect(680, 140, w,h,10);
   fill(0);
   textSize(32);
   text("Blur Kernel",680+100,170);
   
   fill(130);
   stroke(0);
   rect(680, 250, w,h,10);
   fill(0);
   textSize(32);
   text("Outline Kernel",680+100,280);
   

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
  image(pg1, 340,20, 300, 200);
}


// Funcion que arma el histograma, recibe la imagen  y retorna un arreglo de numeros enteros
int[] makeHistogram(PImage img) {
  //ALamcenar los posibles valores de 0 a 255
  int[] histograma = new int[256];

  // Calcular el histograma
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int bright = int(brightness(img.get(i, j)));
      histograma[bright]++;
    }
  }
  return histograma;
}


//Funcion que recorre el histograma y lo dibuja sobre el rectangulo
void drawHistogram(int[] histogram) {
  // Encuentra el maximo valor en el histograma
  int histMaximo = max(histogram);
  pg2.beginDraw();
  pg2.background(153);
  pg2.stroke(255);
  // Dinuja el histogramama  con el tamaño de la imagen cada dos segundos
  for (int i = 0; i < pg2.width; i += 2) {
    //println(pg2.width);
    // Mapea i de 0 a la anchura de la imagen, para localizar el nuemro en el rango de 0 a 255
    int eje_x = int(map(i, 0, pg2.width, 0, 255));
    // Mapea el valor del histograma para ubicalrlo dentro de los valores del rectangulo a dibujar
    //println(eje_x);
    int eje_y = int(map(histogram[eje_x], 0, histMaximo, 430, 260));
    line(i+20,430, i+20, eje_y);
  }
   pg2.endDraw();
   //image(pg2,20, 460, 600, 400);

}


void mouseClicked() {
  
  if(mouseX > 680 && mouseX < 1080 && mouseY > 40 && mouseY < 90){
      option = 1;
  }
  else if(mouseX > 680 && mouseX < 1080 && mouseY > 140 && mouseY < 190){
      option = 2;
  }
  else if(mouseX > 680 && mouseX < 1080 && mouseY > 250 && mouseY < 290)
  {
      option = 3;
  }
  
  else if(mouseX > 20 && mouseX < 340 && mouseY > 230 && mouseY < 430){
    //println(mouseX, mouseY);
    line(mouseX, 430, mouseX, 230 );
    count += 1;
    if(count == 1)
      start = mouseX;
    else if(count == 2){
      end = mouseX;
      option = 4;
    }
  }else{
    option = 0;
    start = 0;
    end = 0;
    count = 0;
  }
  println(start,end);
  

}

void segmentation(int start, int end){
  pg.beginDraw();    
  //Mapea la psociion del mouse dentro del rango 
  int startM = int(map(start, 0, pg.width, 0, 255));
  int endM = int(map(end, 0, pg.width, 0, 255));
  //REcorre cada pixel de la imagen solo dibujando la seccion escogida
  int dimension = pg.width * pg.height;
  pg.loadPixels();
  for (int i = 0; i < dimension; i++) {
    int brightnessOfPixel = int(brightness(pg.pixels[i]));
    if(brightnessOfPixel > startM &&  brightnessOfPixel <endM )
    {
      pg.pixels[i] = img.pixels[i];
    }else{
     pg.pixels[i] = color(200);
    }
  }  
  pg.updatePixels();  
  pg.endDraw();
  image(pg, 20, 20, 300,200);

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
