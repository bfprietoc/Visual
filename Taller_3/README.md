# Visual 2019 I
# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo.
2. Sombrear su superficie a partir de los colores de sus vértices.
3. (opcional para grupos menores de dos) Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas.


Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [nub](https://github.com/nakednous/nub/releases).

## Integrantes


| Integrante | github nick |
|------------|-------------|
| Heyner   Martinez  |hsmartineza  |
| Sergio   Lopez     |SergioLopez40|
| Brayan   Prieto    |bfprietoc|


## Discusión

Describa los resultados obtenidos. En el caso de anti-aliasing describir las técnicas exploradas, citando las referencias.

* Resultados Obtenidos:

Triangulo en cuadricula media
![rejilla1](https://user-images.githubusercontent.com/25939145/58931941-4dc8f280-8727-11e9-8bc5-f5ffe4d70968.png)

Triangulo en cuadricula pequeña
![rejilla2](https://user-images.githubusercontent.com/25939145/58931944-4f92b600-8727-11e9-98f3-835435b73a7b.png)

Triangulo con Anti-Aliasing
![con_aa](https://user-images.githubusercontent.com/25939145/58931924-3f7ad680-8727-11e9-8841-5c8593bc4bd8.png)

Triangulo sin Anti-Aliasing
![sin_aa](https://user-images.githubusercontent.com/25939145/58931934-46a1e480-8727-11e9-83e0-e81e86880d9f.png)

* Anti-aliasing:Se subdivide el píxel en n zonas preferiblemente en 4. La intensidad del color es proporcional al numero de zonas que pertenecen al triangulo.

* Shading: Los puntos dentro del triangulo tienen una proporción de cada color dado su distancia a cada vertice del triangulo.
* Dificultades: Al aumentar el numero de divisiones de cada pixel para hacer el Anti-Alliasing aumenta el tiempo de ejecucion y en muchas casos no dibujaba, haciendo un valor muy bajo de dividir el pixel no se puede apreciar un Anti-Alliasing eficaz.

* Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

## Entrega

* Plazo: 2/6/19 a las 24h.
