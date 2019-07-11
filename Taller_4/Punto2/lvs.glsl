uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;
uniform int lightCount;
uniform vec4 lightPosition[5];
uniform vec3 lightNormal[5];
uniform vec3 lightDiffuse[5];
uniform vec3 lightSpecular[5]; 

attribute vec4 color;
attribute vec4 position;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 cameraDirection;
varying vec3 lightDir[5];
varying float lightDistance[5];
varying vec3 ecPosition;
varying vec3 ecNormal;

void main() {
  gl_Position = transform * position;
  ecPosition = vec3(modelview * position);  
  ecNormal = normalize(normalMatrix * normal);
  
  for(int i = 0; i < lightCount; i++){
  	lightDir[i] = normalize(lightPosition[i].xyz - ecPosition);
    lightDistance[i] = distance(lightPosition[i].xyz,ecPosition);
  }  
  cameraDirection = normalize(0 - ecPosition);  

  vertColor = color;
}