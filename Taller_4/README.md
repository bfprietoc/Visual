# Taller de shaders

## Propósito

Estudiar los [patrones de diseño de shaders](http://visualcomputing.github.io/Shaders/#/4).

## Tarea

1. Hacer un _benchmark_ entre la implementación por software y la de shaders de varias máscaras de convolución aplicadas a imágenes y video.
2. Implementar un modelo de iluminación que combine luz ambiental con varias fuentes puntuales de luz especular y difusa. Tener presente _factores de atenuación_ para las fuentes de iluminación puntuales.
3. (grupos de dos o más) Implementar el [bump mapping](https://en.wikipedia.org/wiki/Bump_mapping).

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
| Heyner   Martinez  |hsmartineza  |
| Sergio   Lopez     |SergioLopez40|
| Brayan   Prieto    |bfprietoc|

## Informe

* Punto 1:

Comparación por software y hardware de máscaras de convolución.

Software:

- Sin mascara:
![homer_sin](https://user-images.githubusercontent.com/25939145/60782724-6dc84900-a10d-11e9-8364-73c100dc4c25.png)

- EDGE DETECTION
![homer_1](https://user-images.githubusercontent.com/25939145/60782731-76208400-a10d-11e9-94db-0a9109279b9a.png)

- Gaussian Blur 
![homer_2](https://user-images.githubusercontent.com/25939145/60782732-76208400-a10d-11e9-8af4-876a29b09e3b.png)

- SHARPEN DETECTION
![homer_3](https://user-images.githubusercontent.com/25939145/60782733-76208400-a10d-11e9-8fbc-40d7d6a29e52.png)

- MOTION BLUR
![homer_13](https://user-images.githubusercontent.com/25939145/60782737-76b91a80-a10d-11e9-9751-01ad8c9d49aa.png)

Hardware:
- Sin mascara Avg FPS: 60
![homer_hard_59](https://user-images.githubusercontent.com/25939145/60782740-7751b100-a10d-11e9-8b47-93f9658f33e9.png)

- EDGE DETECTION Avg FPS: 59-60
![homer_hard1](https://user-images.githubusercontent.com/25939145/60782741-7751b100-a10d-11e9-9ecd-d79c31932fe7.png)

- Gaussian Blur Avg FPS: 59-60
![homer_hard_2](https://user-images.githubusercontent.com/25939145/60782739-76b91a80-a10d-11e9-99e6-25fc1263bccf.png)

- SHARPEN DETECTION Avg FPS: 59-60
![homer_3_hard](https://user-images.githubusercontent.com/25939145/60782735-76208400-a10d-11e9-8056-d9936b5fad8b.png)

- MOTION BLUR Avg FPS: 59-60
![homer_4_hard](https://user-images.githubusercontent.com/25939145/60782736-76208400-a10d-11e9-8fd7-ae7a376172ba.png)

Como se puede observar la diferencia en rendimiento es bastante alta, en hardware los fps se mantienen sobre los 60 casi constantes para cualquier mascara aplicada, mientras que por software se mantienen fluctuando entre 13 y 18 fps. El rendimiento por hardware es bastante alto ya que hace uso de la GPU del computador, comprado por medio del software que no posee estos recurso sino que es realizado por CPU.

* Punto 2:
Para la realizacion de este punto necesitabamos crear diferentes fuentes de luz, para lo cual utilizando la liberia nub, se crearon dichas fuentes de luz como nodes los cuales se pueden mover con el mouse para poder ver la interaccion con el objeto.
Inicialmente definimos el objeto que en este caso sera una esfera de color gris y el shader, luego añadiremos la escena en la cual configuramos la perspectiva utilizando setFrustum y luego añadiremos las fuentes de luz en lugares aleatorios de la escena, pero estaran ocultas hasta que el observador active la cantidad de luces que desea utilizando las teclas numericas del 1 al 5. Desde el sketch basicamente solo cargaremos el fragment y vertex shader de iluminacion que creamos. 

Desde el shader se realizan todas las operaciones implicadas con las fuentes de iluminacion, alli se realizaran las operaciones de normalizacion relacionados a las normales y a el punto de vista de la camara, ademas de con esto, poder calcular la informacion de la luz especular y la luz difusa, teniendo en cuenta que para poder calcular la luz difusa necesitamos el producto punto de la direccion de las fuentes de luz y su normal. Para la especular en cambio utilizamos la direccion de la fuente de luz reflejada por la normal y el observador en este caso el punto de vista de la camara.
La luz ambiental definida como un color, decidimos que fuera de un color oscuro para no quemar la escena. Finalmente la iluminacion sera igual a dicha luz ambiental mas la suma de las sumatorias de la luz especular y difusa por el color.
Para el factor de atenuacion nos basamos en esta informacion: 
https://docs.microsoft.com/es-es/windows/uwp/graphics-concepts/attenuation-and-spotlight-factor
Donde la atenuación de una luz depende del tipo de luz y de la distancia entre la luz y la posición del vértice

Este es el resultado obtenido del taller con diferentes fuentes de luz


