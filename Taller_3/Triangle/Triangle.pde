import nub.timing.*;
import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P3D;

Point punto;

float[] colR = {1,0,0};
float[] colG = {0,1,0};
float[] colB = {0,0,1};


// 4. Window dimension
int dim = 9;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub.timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask() {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };
  scene.registerTask(spinningTask);

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pushMatrix();
  pushStyle();
  scene.applyTransformation(node);
  triangleRaster();
  popStyle();
  popMatrix();
}

float escena[][];
// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n

void triangleRaster() {
  
  noStroke();
  rectMode(CENTER);
  escena = new float[(int)pow(2, n)][(int)pow(2, n)];
  float[] rgb = new float[0];
  float z1 = (1/scene.screenLocation(v1).z());
  float z2 = (1/scene.screenLocation(v2).z());
  float z3 = (1/scene.screenLocation(v3).z());
  
  
  
  
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  if (debug) {
    pushStyle();
    stroke(255, 255, 0, 125);
    point(round(node.location(v1).x()), round(node.location(v1).y()));
    stroke(200, 100, 0, 125);
    point(round(node.location(v2).x()), round(node.location(v2).y()));
    stroke(255, 0, 255, 125);
    point(round(node.location(v3).x()), round(node.location(v3).y()));
    popStyle();
  }
}

float[] edgeFun(Vector v1, Vector v2, Vector v3, float PosX,float PosY){
  float e1 =((PosX - node.location(v1).x()) * (node.location(v2).y() - node.location(v1).y()) - (PosY - node.location(v1).y()) * (node.location(v2).x() - node.location(v1).x()));
  float e2 =((PosX - node.location(v2).x()) * (node.location(v3).y() - node.location(v2).y()) - (PosY - node.location(v2).y()) * (node.location(v3).x() - node.location(v2).x()));
  float e3 =((PosX - node.location(v3).x()) * (node.location(v1).y() - node.location(v3).y()) - (PosY - node.location(v3).y()) * (node.location(v1).x() - node.location(v3).x()));
  float area = (PosX-node.location(v1).x())*(node.location(v2).y()-node.location(v1).y())-(PosY-node.location(v1).y())*(node.location(v2).x()-node.location(v1).x());
  if(e1>=0 && e2>=0 && e3>=0  ||  e1<=0 && e2<=0 && e3<=0){
    float p1 = e1/area;
    float p2 = e2/area;
    float p3 = e3/area;
    float[] pesos = {p1,p2,p3};
    return pesos;
  }
float[] pesos = {0,0,0};
  return pesos;
}

boolean edgeV(Vector v1, Vector v2, Vector v3, float PosX,float PosY){
  float e1 =((PosX - node.location(v1).x()) * (node.location(v2).y() - node.location(v1).y()) - (PosY - node.location(v1).y()) * (node.location(v2).x() - node.location(v1).x()));
  float e2 =((PosX - node.location(v2).x()) * (node.location(v3).y() - node.location(v2).y()) - (PosY - node.location(v2).y()) * (node.location(v3).x() - node.location(v2).x()));
  float e3 =((PosX - node.location(v3).x()) * (node.location(v1).y() - node.location(v3).y()) - (PosY - node.location(v3).y()) * (node.location(v1).x() - node.location(v3).x()));
  if(e1>=0 && e2>=0 && e3>=0  ||  e1<=0 && e2<=0 && e3<=0){
    return true;
  }else{
    return false;
  }
}

float[] edgeColors(Vector v1, Vector v2, Vector v3, float PosX,float PosY){
  float e1 =((PosX - node.location(v1).x()) * (node.location(v2).y() - node.location(v1).y()) - (PosY - node.location(v1).y()) * (node.location(v2).x() - node.location(v1).x()));
  float e2 =((PosX - node.location(v2).x()) * (node.location(v3).y() - node.location(v2).y()) - (PosY - node.location(v2).y()) * (node.location(v3).x() - node.location(v2).x()));
  float e3 =((PosX - node.location(v3).x()) * (node.location(v1).y() - node.location(v3).y()) - (PosY - node.location(v3).y()) * (node.location(v1).x() - node.location(v3).x()));
  float area = (PosX-node.location(v1).x())*(node.location(v2).y()-node.location(v1).y())-(PosY-node.location(v1).y())*(node.location(v2).x()-node.location(v1).x());
  if(e1>=0 && e2>=0 && e3>=0  ||  e1<=0 && e2<=0 && e3<=0){
    float p1 = e1/area;
    float p2 = e2/area;
    float p3 = e3/area;
    float r = (p1 * colR[0]) + (p2 * colG[0]) + (p3 * colB[0]); 
    float g = (p1 * colR[1]) + (p2 * colG[1]) + (p3 * colB[1]);
    float b = (p1 * colR[2]) + (p2 * colG[2]) + (p3 * colB[2]);
    float[] colors = {r, g, b};
    return colors;
  } else { 
    //println("Outside");
    float[] colorsneg = {0, 0, 0};
    return colorsneg;
  }
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  pushStyle();
  noFill();
  strokeWeight(2);
  stroke(255, 0, 0);
  triangle(v1.x(), v1.y(), v2.x(), v2.y(), v3.x(), v3.y());
  strokeWeight(5);
  stroke(0, 255, 255);
  point(v1.x(), v1.y());
  point(v2.x(), v2.y());
  point(v3.x(), v3.y());
  popStyle();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;

}