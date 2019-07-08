import processing.video.*;

Movie video;

PImage image;
PShape movie; 
PShader convShader;
int maskSelected = 1;
boolean enabledMasks = false;


void setup() {
  size(1200, 700, P3D);
  //video = new Movie(this, "homer.mp4");
  video = new Movie(this, "paisaje.mp4");
  video.loop();
  convShader = loadShader("convfrag.glsl");
  background(0);

}

void draw() {
  //drawResults();
  shader(convShader);
  convShader.set("maskSelected", maskSelected);
  convShader.set("showMask", enabledMasks);
  translate(50, height/2);
  if (video.available()) {
    video.read();
    movie  = drawMovie(1100, 500, video, 100);
    println("FPS: " + int(frameRate));  
    shape(movie);
  }
}

PShape drawMovie(int imageWidht, int imageHeight, PImage texture, int detail) {
  textureMode(NORMAL); // Normalize the coordinates in texture [0,1]
  PShape wd = createShape();
  wd.beginShape(QUAD_STRIP); // First 4 coordinates generate an rectangle the next two too.
  wd.noStroke();
  wd.texture(texture);
  for (int i = 0; i <= detail; i++) {
    float u = float(i) / detail;
    float x = (imageWidht / detail) * i;
    wd.normal(1, 0, 1); // Out side in plane z-x
    wd.vertex(x, -imageHeight/2, 1, u, 0);
    wd.vertex(x, imageHeight/2, 1, u, 1);
  }
  wd.endShape();  
  return wd;
}



void keyPressed() {
  handleKeyPress(key);
}
void handleKeyPress(char pressed) { 
  if (pressed == 'm') {
    enabledMasks = !enabledMasks;
  }
  if (pressed == '1') {
    maskSelected = 1;
  }
  if (pressed == '2') {
    maskSelected = 2;
  }
    if (pressed == '3') {
    maskSelected = 3;
  }
  
  if (pressed == '4') {
    maskSelected = 4;
  }
}
