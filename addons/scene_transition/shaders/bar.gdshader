shader_type canvas_item;

uniform bool on_y_axis = false;
uniform float threshold: hint_range(0.0, 1.0) = 0.5;

float y_bar(vec2 tiled_uv){	
	if (tiled_uv.y < 0.5){
		if(tiled_uv.y > threshold / 2.0){
			return 0.0;
		} else {
			return 1.0;
		}
	} else {
		if (tiled_uv.y < 1. - threshold / 2.0){
			return 0.0;
		} else {
			return 1.0;
		}
	}
}

float x_bar(vec2 tiled_uv){	
	if (tiled_uv.x < 0.5){
		if(tiled_uv.x > threshold / 2.0){
			return 0.0;
		} else {
			return 1.0;
		}
	} else {
		if (tiled_uv.x < 1. - threshold / 2.0){
			return 0.0;
		} else {
			return 1.0;
		}
	}
}

void fragment() {
	vec2 tiled_uv = vec2(fract(UV.x), UV.y);
	
	if(on_y_axis){
		COLOR.a = y_bar(tiled_uv);
	}else{
		COLOR.a = x_bar(tiled_uv);
	}
}

