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

## Entrega

Fecha límite ~~Lunes 1/7/19~~ Domingo 7/7/19 a las 24h. Sustentaciones: 10/7/19 y 11/7/19.
