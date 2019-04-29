# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises.
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Heyner   Martinez  |hsmartineza  |
|                    |             |

## Discusión

Despliegue del Histograma: Para realizar el histograma  de la imagen  se crea un  arreglo de enteros  de tamaño 255, el cual almacenara las frecuencias que van del rango de 0 a 255,  las frecuencias se almacenaran al recorrer cada pixel de  la imagen obtenido el  brightness del píxel.
Luego se dibujara el histograma realizando un mapeo  sobre el eje horizontal  para ubicar los valores de 0 a 255 según la anchura de la imagen, y  verticalmente ubicar las frecuencias según la altura del rectángulo, para dibujar las frecuencias almacenadas en el arreglo como lineas.
Para realizar la segmentación se ubica la coordenada del eje x  del mouse, se crea una copia de la imagen y se recorre cada pixel de la imagen original obtenido el brightness, verificando  que se encuentre dentro del rango establecido, si es valido el pixel hará parte de la imagen duplicada. Obtenido de esta manera una nueva imagen con la segmentación realizada.
Se puede observar que se obtiene un histograma el cual ubica los tonos claros hacia la derecha, los medios en el centro y los mas oscuros hacia la izquierda, a través de este proceso se puede realizar una calibración de la imagen su brillo  y contraste , y  con ayuda de la segmentación realizar un análisis mas profundo de la imagen.
## Entrega

* Hacer [fork](https://help.github.com/articles/fork-a-repo/) de la plantilla. Plazo: 28/4/19 a las 24h.
* (todos los integrantes) Presentar el trabajo presencialmente en la siguiente sesión de taller.
