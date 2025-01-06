shader_type canvas_item;

uniform sampler2D dissolve_texture;
uniform float amount : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	float sample = texture(dissolve_texture, UV).r;
	COLOR.a = step(sample, amount);
}