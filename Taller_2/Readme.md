 # Taller ilusiones visuales

## Propósito

Comprender algunos aspectos fundamentales de la [inferencia inconsciente](https://github.com/VisualComputing/Cognitive) de la percepción visual humana.

## Tareas

Implementar al menos 6 ilusiones de tres tipos distintos (paradójicas, geométricas, ambiguas, etc.), al menos dos con movimiento y dos con interactividad.

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Heyner   Martinez  |hsmartineza  |
| Sergio   Lopez     |SergioLopez40|
| Brayan   Prieto    |bfprietoc|

## Discusión

1. Complete la tabla

| Ilusión | Categoria | Referencia | Tipo de interactividad (si aplica) | URL código base (si aplica) |
|---------|-----------|------------|------------------------------------|-----------------------------|
|Ambigua|Ambigua|http://www6.uniovi.es/vision/intro/node5.html|         |                             |
|Moire_Interactive|Movimiento ilusorio(Motion)| https://michaelbach.de/ot/mot-scanimation/|KeyPressed: 1,2,3 y4 para elegir imagen del fondo y rejilla movil controlada con el mouse||
|Moire_Movement|Movimiento ilusorio(Motion)|https://michaelbach.de/ot/lum-moire1/index.html|MouseClicked: Para cambiar la direccion del movimiento||
|Orbita|           |            |                                    |                             |
|Wheel|           |            |                                    |                             |
|Moire Box|Geométrica |https://en.wikipedia.org/wiki/Moir%C3%A9_pattern             |Con las teclas Up y Down aumenta y disminuye respectivamente la distancia  de separacion de las lineas                                    |                https://thinkspacestudio.com/tutorials/moire_loops_in_java             |
|Ponzo Illusion   | Distorsión          | https://feeldoppel.com/blogs/news/optical-illusions-explained    | Con la tecla UP dibuja las líneas para verificar que el tamaño de los rectángulos sean iguales|


2. Describa brevememente las referencias estudiadas y los posibles temas en los que le gustaría profundizar

 * Ilusiones Ambiguas: Son imágenes con ilusiones ópticas que explotan similitudes gráficas y otras propiedades de la interpretación del sistema visual entre dos o más formas distintas de imágenes. Introducen el fenómeno de la percepción multiestable, es decir una imagen es capaz de proveer múltiples percepciones estables. En nuestro ejemplo especifico, es posible ver como una imagen vista desde dos angulos diferentes permite identificar con mayor claridad un animal u otro(León y Ratón).
 * Moiré Pattern: Es un patrón de interferencia que se forma cuando se superponen dos rejillas de líneas, ya sean rectas o curvas, con un cierto ángulo o cuando tales rejillas tienen tamaños ligeramente diferentes. La visión humana crea la ilusión de unas bandas oscuras y claras horizontales, que se superponen a las líneas finas que en realidad son las que forman el trazo. Patrones de moiré más complejos pueden formarse igualmente al superponer figuras complejas hechas de líneas curvas y entrelazadas. Si cada una de las rejillas tiene un color distinto, el patrón de muaré resultante será de un tercer color. Me gustaria profundizar mas en este tema, y en como estas figuras mas complejas pueden generar patrones mas complejos que simulan movimientos y colores inesperados.
* Ponzo Illusion: La línea superior se hace más larga porque interpretamos los lados convergentes según la perspectiva lineal como líneas paralelas que retroceden en la distancia. La línea superior se interpreta como si estuviera más lejos, así que se ve más larga - un objeto más lejano tendría que ser más largo que uno más cercano para que ambos produzcan imágenes de la retina del mismo tamaño.
* Moiré box: Se trata de cuatro triángulos hechos con varias líneas trazadas desde la parte superior el punto de convergencia a la base, en donde se visualizar un patrón Moiré con forma de diamante, este patrón se debe a que se esta dibujando en un pantalla de computador que es una cuadricula de pixeles, el cual realiza una aproximación de una línea recta, rellenado con pixeles con variables de color, este proceso se le conoce como anti-aliasing.
<img src="https://thinkspacestudio.com/images/tuts/triangle-line.png" >


Me gustaría abordar en el tema de anti-aliasing, como se aplican estas técnicas principalmente en los videojuegos.

## Entrega

* Hacer [fork](https://help.github.com/articles/fork-a-repo/) de la plantilla. Plazo: 12/5/19 a las 24h.
* (todos los integrantes) Presentar el trabajo presencialmente en la siguiente sesión de taller.
