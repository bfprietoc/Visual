int distance = 5;

void setup()
{
  size( 600, 400 );
}

void draw()
{
  background( 255 );
  noFill();
  stroke( 0 );

  //Dibuja lineas de izquierda a derecha para la parte superio e inferior del canvas
  for ( int x = 0; x <= width; x = x + distance ) {
    line( mouseX, mouseY, x, 0 ); // draw line to the top
    line( mouseX, mouseY, x, height ); // draw line to the bottom
  }

  //Dibuja lineas de arriba hacia abajo para los lados del canvas.
  for ( int y = 5; y < height; y = y + distance ) {
    line( mouseX, mouseY, 0, y );
    line( mouseX, mouseY, width, y );
  }


}

void keyPressed()
{
  //Aumenta la distancia de separacion de las lineas cuando se presiona la key UP
  if ( keyCode == UP ) {
    distance++; 
  }

  //Disminuye la distancia de separacion de las lineas cuando se presiona la tecla DOWN
  else if ( keyCode == DOWN && distance > 1 ) {
    distance--; 
  }
}
