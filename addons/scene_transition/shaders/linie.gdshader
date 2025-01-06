// https://godotshaders.com/shader/lines-screen-transition/

shader_type canvas_item;

uniform float num_lines = 20.;
uniform bool on_y_axis = true;
uniform float threshold: hint_range(0.0, 1.0) = 0.5;

float y_linies(vec2 tiled_uv){
	if (tiled_uv.x < 0.5){
		if(tiled_uv.y < threshold){
			return 1.0;
		} else {
			return 0.0;
		}
	} else {
		if (tiled_uv.y > 1. - threshold){
			return 1.0;
		} else {
			return 0.0;
		}
	}
}

float x_linies(vec2 tiled_uv){
	if (tiled_uv.y < 0.5){
		if(tiled_uv.x < threshold){
			return 1.0;
		} else {
			return 0.0;
		}
	} else {
		if (tiled_uv.x > 1. - threshold){
			return 1.0;
		} else {
			return 0.0;
		}
	}
}

void fragment() {
	vec2 tiled_uv_y = vec2(fract(UV.x * num_lines / 2.), UV.y);
	vec2 tiled_uv_x = vec2(UV.x, fract(UV.y * num_lines / 2.));

	if(on_y_axis){
		COLOR.a = y_linies(tiled_uv_y);
	}else{
		COLOR.a = x_linies(tiled_uv_x);
	}

}
