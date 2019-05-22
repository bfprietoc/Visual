int option = 0;
void setup()
{
  size( 800, 700 );
}


void draw()
{
  if(option == 0){
    drawIllusion();
    
  }
  else if(option == 1){
  
    drawLines();
  
  }
  


}

//Dibuja la ilusion  con las lineas
void drawLines(){
  
  int weidhtRect = 50;
  float position = 0;
  float heightRect = 10;
  background( 255 );
  fill(0);
  rectMode(CENTER);
  noStroke();
  // Dibuja de izquierda a derecha rectangulos
  for ( int x = 0; x <= height-100; x = x + 13 ) {
    weidhtRect = weidhtRect + 33;
    position = position + (x * 0.5);
    heightRect = heightRect + 0.3;
    if(position > 30 && position < 700)
      rect( 400,position, weidhtRect, heightRect );
  }
  quad(329,3,337,3,142,784,134,784);
  quad(470,3,477,3,650,784,643,784);
  color c = color(255, 204, 0);  // Define color 'c'
  fill(c);  // Use color variable 'c' as fill color
  noStroke();
  rect(400,159, 200, 15 );
  rect(400,550, 200, 15 );
  stroke(0);
  line( 300, 0, 300, 800 );
  line( 500, 0, 500, 800 );
}




//Dibuja la ilusion  sin las lineas
void drawIllusion(){
  
  int weidhtRect = 50;
  float position = 0;
  float heightRect = 10;
  background( 255 );
  fill(0);
  rectMode(CENTER);
  // loop from left to right, drawing lines to the top of the canvas:
  for ( int x = 0; x <= height-100; x = x + 13 ) {
    weidhtRect = weidhtRect + 33;
    position = position + (x * 0.5);
    heightRect = heightRect + 0.3;
    if(position > 30 && position < 700)
      rect( 400,position, weidhtRect, heightRect );
  }
  quad(329,3,337,3,142,784,134,784);
  quad(470,3,477,3,650,784,643,784);
  color c = color(255, 204, 0);  // Define color 'c'
  fill(c);  // Use color variable 'c' as fill color
  noStroke();
  rect(400,159, 200, 15 );
  rect(400,550, 200, 15 );
  
}

void keyPressed() {
  

    //Aumenta la distancia de separacion de las lineas cuando se presiona la key UP
  if ( keyCode == UP ) {
    option = 1;
  }
  //Disminuye la distancia de separacion de las lineas cuando se presiona la tecla DOWN
  else if ( keyCode == DOWN) {
    option = 0;
  }

}
