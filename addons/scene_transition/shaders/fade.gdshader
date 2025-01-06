shader_type canvas_item;

uniform float amount: hint_range(0.0, 1.0) = 0.5;

void fragment() {
	COLOR.a = amount;
}

