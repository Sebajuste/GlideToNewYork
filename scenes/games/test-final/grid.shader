shader_type spatial;
varying vec3 world_position;

uniform vec4 color : hint_color = vec4(1);
uniform float grid_size = 100.0;
uniform float grid_weight = 0.1;

void vertex() {
	world_position = VERTEX;
}

void fragment() {
	vec3 pos = world_position;
	
	float x = fract(pos.x * grid_size);
	float y = fract(pos.y * grid_size);
	float z = fract(pos.z * grid_size);
	
	if( ( x < grid_weight) || z < grid_weight || y < grid_weight ) {
		ALBEDO = color.rgb;
	}
	else
	{
		ALBEDO = vec3(0);
		
	}
	
	// ALBEDO = vec3(0);
}