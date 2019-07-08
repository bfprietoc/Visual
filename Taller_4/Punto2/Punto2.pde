import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

Scene scene;
PShape sphere;
float angulo; 
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
  scene.setFrustum(new Vector(0, 0, 0), new Vector(650, 650, 650));
  scene.fit();
  ColorFLuz[0] = color(255, 255, 255);
  for(int i = 1;i < a;i++){
    ColorFLuz[i] = color(random(255), random(255), random(255));
  }   
  for(int i = 0;i < a;i++){
    FLuz[i] = new Sphere(scene, ColorFLuz[i], 50);
    FLuz[i].setPosition(new Vector(random(-400,400), random(-400,400), random(-400,400)));
    FLuz[i].cull(true);
  }  
  lightShader = loadShader("lfs.glsl", "lvs.glsl");
  noStroke();
  sphere = createShape(SPHERE, 200);
}

void draw() {    
  background(51,25,0);
  scene.render();
  shader(lightShader);
  lightShader.set("brillo", brillo);
  lightShader.set( "ambiental", new PVector(red(esfera), green(esfera), blue(esfera)).div(255) );
  
  for(int i = 0;i < NFLuz;i++){
    FLuz[i].cull(false);
    Vector lightv = FLuz[i].position();
    lightSpecular(red(ColorFLuz[i]), green(ColorFLuz[i]), blue(ColorFLuz[i]));
    pointLight(red(ColorFLuz[i]), green(ColorFLuz[i]), blue(ColorFLuz[i]), lightv.x(), lightv.y(), lightv.z());
  }
  
  // Dibujamos la esfera
  pushMatrix();
  translate(width/2, height/2);
  shape(sphere);
  popMatrix();
  resetShader();
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
