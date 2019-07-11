uniform int lightCount;
uniform vec3 lightDiffuse[5];
uniform vec3 lightSpecular[5]; 
uniform vec3 ambiental;
uniform float brillo;

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 cameraDirection;
varying vec3 lightDir[5];
varying float lightDistance[5];

void main() {

  vec3 camera = normalize(cameraDirection);
  vec3 normal = normalize(ecNormal);  
  
  vec3 totalDiffuse = vec3(0, 0, 0);
  vec3 totalSpecular = vec3(0, 0, 0);
  for(int i = 0; i < lightCount; i++){

    vec3 lightDir = mat3(vec3(1,0,0), vec3(0,1,0), vec3(0,0,1)) * normalize( lightDir[i] );    
    float b = 1.0 / (900*900 * 0.5);
    float atenuacion = 1.0 / (1.0 + b*lightDistance[i] + b*pow(lightDistance[i],2));

    vec3 direction = normalize(lightDir);
    vec3 ref = reflect( -direction, normal);

  	totalSpecular += lightSpecular[i] * pow(max(0.0, dot(ref, camera)) , brillo)* atenuacion;	
    totalDiffuse += lightDiffuse[i] * max(0.0, dot(direction, normal)) * atenuacion;
  }

  gl_FragColor = (vec4(ambiental, 1) + vec4(totalDiffuse, 1) + vec4(totalSpecular, 1) ) * vec4(vertColor.xyz,1);
}