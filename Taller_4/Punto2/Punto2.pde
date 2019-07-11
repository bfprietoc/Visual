import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

Scene scene;
PShape sphere;
PShader lightShader;
int a = 5; // Numero para aumentar o disminuir el tamaño de los arreglos que contiene las fuentes de luz y los colores de las mismas
int NFLuz = 3;   // Numero de fuentes de luz 
Node[] FLuz = new Node[a]; //Node con hasta 5 fuentes de luz
color[] ColorFLuz = new color[a]; //arreglo con los colores que tendran las fuentes de luz
float brillo = 4.0; // valor con el brillo inicial que tendran las fuentes de luz
color esfera = color(32, 32, 32); // Color inicial de la esfera

void setup() {
  size(800, 650, P3D);
  scene = new Scene(this);
  scene.setFrustum(new Vector(0, 0, 0), new Vector(900, 900, 900));
  scene.fit();
  ColorFLuz[0] = color(255, 255, 255);
  for(int i = 1;i < a;i++){
    ColorFLuz[i] = color(random(255), random(255), random(255));
  }   
  for(int i = 0;i < a;i++){
    FLuz[i] = new Sphere(scene, ColorFLuz[i], 50);
    FLuz[i].setPosition(new Vector(random(-600,600), random(-600,600), random(-600,600)));
    FLuz[i].cull(true);
  }  
  lightShader = loadShader("lfs.glsl", "lvs.glsl");
  noStroke();
  sphere = createShape(SPHERE, 200);
}

void draw() {    
  background(0);
  scene.render();
  shader(lightShader);
  lightShader.set("brillo", brillo);
  lightShader.set("ambiental", new PVector(red(esfera), green(esfera), blue(esfera)).div(255) );

  for(int i = 0;i < NFLuz;i++){
    FLuz[i].cull(false);
    Vector light = FLuz[i].position();
    lightSpecular(red(ColorFLuz[i]), green(ColorFLuz[i]), blue(ColorFLuz[i]));
    pointLight(red(ColorFLuz[i]), green(ColorFLuz[i]), blue(ColorFLuz[i]), light.x(), light.y(), light.z());
  }
  
  // Dibujamos la esfera
  pushMatrix();
  translate(width/2, height/2);
  shape(sphere);
  popMatrix();
  resetShader();
}

//Interaccion con los numeros del 1 al 5, para aumentar y disminuir el numero de fuentes de luz , con 1 sera 1 sola fuente de luz y asi reespectivamente
void keyPressed(){
  if(key == '1'){
   NFLuz = 1;
   for(int i = 0;i < a;i++){
     if(NFLuz <= i){
        FLuz[i].cull(true);  
      }else{
        FLuz[i].cull(false);
      }
    }
  }  
  if(key == '2'){
   NFLuz = 2;
   for(int i = 0;i < a;i++){
     if(NFLuz <= i){
        FLuz[i].cull(true);  
      }else{
        FLuz[i].cull(false);
      }
    }
  }  
  if(key == '3'){
   NFLuz = 3;
   for(int i = 0;i < a;i++){
     if(NFLuz <= i){
        FLuz[i].cull(true);  
      }else{
        FLuz[i].cull(false);
      }
    }
  }  
  if(key == '4'){
   NFLuz = 4;
   for(int i = 0;i < a;i++){
     if(NFLuz <= i){
        FLuz[i].cull(true);  
      }else{
        FLuz[i].cull(false);
      }
    }
  }  
  if(key == '5'){
   NFLuz = 5;
   for(int i = 0;i < a;i++){
     if(NFLuz <= i){
        FLuz[i].cull(true);  
      }else{
        FLuz[i].cull(false);
      }
    }
  }  
  if(key == '+'){
   brillo = max(1,brillo/2);
  }
  if(key == '-'){
   brillo = min(96,brillo*2);
  }
}

void mouseMoved() {
  scene.cast();
}

void mouseDragged() {
  if (mouseButton == RIGHT)
    scene.spin();
  else if (mouseButton == LEFT)
    scene.translate();
  else
    scene.scale(mouseX - pmouseX);
}
