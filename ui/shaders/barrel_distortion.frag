#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;
uniform sampler2D uTexture;

out vec4 FragColor;

#define PI 3.1415
#define thickness 3.6
#define speed 3.0
#define fade 0.005


vec2 brownConradyDistortion(vec2 p){
  float barrelDistortion1 = abs(0.4*sin(uTime*PI*4));
  float barrelDistortion2 = 0.0;
  float r2 = p.x*p.x + p.y*p.y;
  p *= 2.*abs(cos(uTime*PI*4)) + barrelDistortion1 * r2 + barrelDistortion2 * r2 * r2;
  return p;
}


void main() {
  vec2 uv = (FlutterFragCoord() - uSize.xy * 0.5) / min(uSize.x, uSize.y) * 2.0;

  float r = uTime*speed-length(uv);
  float x = r + uTime;
  float d = mod(x, 1.4) * 10.0;
  vec3 ring = vec3(smoothstep(0.0, fade, d));
  ring *= vec3(smoothstep(thickness+fade, thickness, d));
  ring *= vec3(0.2,0.2,0.2);

  uv = brownConradyDistortion(uv);
  uv = 0.5 * (uv * 0.5 + 1.0);
   
  vec4 col = texture(uTexture, uv);
  if (ring != vec3(0.0)) {
      col = mix(col, vec4(ring, 1.0), 0.3);       
  } 
	FragColor = col;
}

