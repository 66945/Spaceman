shader_type canvas_item;

uniform sampler2D mask : hint_albedo;

void fragment() {
	vec3 col = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	
	float brightness = (col.r + col.g + col.b) / 3.0;
	vec3 invert = vec3(0.0, 1.0 - brightness, 0.0);
	COLOR = vec4(invert, texture(mask, UV).a);
}