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

float[] dBuffer;

// 4. Window dimension
int dim = 10;

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
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  if (debug) {
    pushStyle();
  strokeWeight(0);
    stroke(255, 255, 0, 125);
    //Posicion x,y v1
    float v1x= (node.location(v1).x());
    float v1y= (node.location(v1).y());
    //Posicion x,y v2
    float v2x= (node.location(v2).x());
    float v2y= (node.location(v2).y());
    //Posicion x,y v3
    float v3x= (node.location(v3).x());
    float v3y= (node.location(v3).y());
    
    float v1z= (scene.eye().location(v1).z())*-1;
    float v2z= (scene.eye().location(v2).z())*-1;
    float v3z= (scene.eye().location(v3).z())*-1;
        
    FloatList dBuffer=new FloatList();
    for(int i=0; i<width*height;i++){
      dBuffer.append(1000);
    }
    float aliasing=0.25;
    float cant= 1/aliasing;
    point(0,0);
    
    int maxx=round(max(v1x,v2x,v3x));
    int maxy=round(max(v1y,v2y,v3y));
    int minx=round(min(v1x,v2x,v3x));
    int miny=round(min(v1y,v2y,v3y));
    int s=round(width/pow(2, n));
    
    for(int px= minx; px<=maxx; px++){
      for(int py= miny; py<=maxy; py++){
          
          boolean dentro=false;
          float c1=0;
          float c2=0;
          float c3=0;
          //anti aliasing
          for(float x= px; x<px+1; x+=aliasing){
            for(float y= py; y<py+1; y+=aliasing){
              float w1= edgeFunction(v1x,v1y, v2x, v2y, x, y); 
              float w2= edgeFunction(v2x, v2y, v3x, v3y, x, y); 
              float w3= edgeFunction(v3x, v3y, v1x,v1y, x, y);
              if(w1 >= 0 && w2 >= 0 && w3 >= 0){
                dentro=true;
                float area=w1+w2+w3;
                c1+=w1/area;
                c2+=w2/area;
                c3+=w3/area;
              }                  
            }
          }
          if(dentro){
            fill((c1/cant)*255, (c2/cant)*255, (c3/cant)*255);
            rectMode(CENTER);
            rect(px, py,1,1);
            
            float z= v1z * c1 + v2z * c2 + v3z * c3;
            if(z< dBuffer.get((height/2+py)*s+(width/2+px))){
              dBuffer.set((height/2+py)*s+(width/2+px),z);
            }
        }
      }
    }

    popStyle();
  }
}


float edgeFunction(float ax, float ay, float bx, float by, float px, float py) 
{ 
  float ppx=px;
  float ppy=py;
  return ((ppx - ax) * (by - ay) - (ppy - ay) * (bx - ax)); 
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
    if(edgeFunction(v1.x(),v1.y(),v2.x(),v2.y(),v3.x(),v3.y())<0){
    Vector v=new Vector(v2.x(), v2.y());
    v2=new Vector(v3.x(), v3.y());
    v3=new Vector(v.x(), v.y());
  }
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
  if (key == 'r'){
      println("entre");
      randomizeTriangle();
  }
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run(20);
  if (key == 'y')
    yDirection = !yDirection;
}
