#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;
uniform sampler2D uTexture;

out vec4 FragColor;

#define PI 3.1415

float uPower = 0.4;
float uFrequency = 12.0;

void main() {
	vec2 uv = FlutterFragCoord() / uSize;
	uv.x *= uSize.x/uSize.y;
	vec2 toCenter = uv - 0.5;
	float distToCenter = length(toCenter);
	float sinArg = distToCenter * uPower - uTime * uFrequency;
	float slope = sin(sinArg*PI);
	uv = uv  + normalize(toCenter) * slope * 0.05;
	vec3 col = texture(uTexture, uv).xyz;
	float alpha = texture(uTexture, uv).a;

	FragColor = vec4(col, alpha);
}



   