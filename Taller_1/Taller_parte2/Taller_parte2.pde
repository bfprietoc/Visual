PGraphics pg1;

void setup() {

  size(1920, 1080);
  PImage img = loadImage("paisaje.jpg");
  image(img, 0, 0);
    pg1 = createGraphics(img.width, img.height);

  // Dibuja un rectangulo en donde se ubicara el histograma 
  fill(153);
  rect(0, img.height + 20, img.width, img.height/2);
  int[] histogram = makeHistogram(img);
  drawHistogram(histogram,img);
}


// FUncion que arma el histograma, recibe la imagen  y retorna un arreglo de numeros enteros
int[] makeHistogram(PImage img) {
  //ALamcenar los posibles valores de 0 a 255
  int[] histogram = new int[256];

  // Calcular el histograma
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      int bright = int(brightness(get(i, j)));
      histogram[bright]++;
    }
  }
  return histogram;
}

//Funcion que recorre el histograma y lo dibuja sobre el rectangulo
void drawHistogram(int[] histogram, PImage img) {
  // Encuentra el maximo valor en el histograma
  int histMaximo = max(histogram);
  double position = img.height *1.5 + 20;
  stroke(255);
  // Dinuja el histogramama  con el tamaño de la imgen cada dos segunod
  for (int i = 0; i < img.width; i += 2) {
    // Mapea i de 0 a la anchura de la imagen, para localizar el nuemro en el rango de 0 a 255
    int eje_x = int(map(i, 0, img.width, 0, 255));
    // Mapea el valor del histograma para ubicalrlo dentor de los valores del rectangulo a dibujar
    int eje_y = int(map(histogram[eje_x], 0, histMaximo, img.height*1.5, img.height/2));
    line(i, img.height *1.5 +20, i,eje_y);
  }
  
  if(mouseX>0 && mouseX<img.width && mouseY>img.height + 20 && mouseY<img.height+20 && mousePressed==true){
  segmentation(img);
  }

}

//Funcion que realiza la segmetnacion
void segmentation(PImage img){
  pg1.beginDraw();    
  int posX;
  PImage img_duplicate;
  //CRea una copiad  ela imagen   
  img_duplicate = createImage(img.width, img.height, RGB);
  //Obtiene posisicon del mouse sobre el eje x
  posX = mouseX;
  //Mapea la psociion del mouse dentro del rango 
  int eje_x = int(map(posX, 0, img.width, 0, 255));
  int endM = int(map(img.width, 0, img.width, 0, 255));
  //REcorre cada pixel de la imagen solo dibujando la seccion escogida
  int dimension = img.width * img.height;
  for (int i = 0; i < dimension; i++) {
    int brightnessOfPixel = int(brightness(img.pixels[i]));
    if(brightnessOfPixel > eje_x &&  brightnessOfPixel <endM )
    {
    img_duplicate.pixels[i] = img.pixels[i];
  }else{
     img_duplicate.pixels[i] = color(200);
    }
  }  
  img_duplicate.updatePixels();
  pg1.image(img_duplicate, 0, img.height);
  pg1.endDraw();
  image(pg1,510,20);

}
