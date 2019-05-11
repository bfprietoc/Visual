PImage dino, colibri, Engranajes, Cubo, re;

void setup(){
  size(1024,680);
  dino = loadImage("Dino.bmp"); 
  colibri = loadImage("Colibri.jpg");
  Engranajes = loadImage("gear.bmp"); 
  Cubo = loadImage("Cubo.bmp"); 
  re = loadImage("Rejilla.png"); 
}

void draw(){
  background(255);
  textSize(25);
  fill(50);
  text("Dar click y seleccionar imagen con los numeros 1, 2, 3 y 4",20, 40);  
  keyPressed(dino, colibri, Engranajes, Cubo);
  image(re, mouseX, mouseY);  
}

void keyPressed(PImage dino,PImage colibri,PImage Engranajes,PImage Cubo) {
  if (key == '1'){
    image(dino, 20, 50);
  }
  if (key == '2'){
    image(colibri, 20, 50);
  }
  if (key == '3'){
    image(Engranajes, 20, 50);
  }
  if (key == '4'){
    image(Cubo, 20, 50);
  }
}
