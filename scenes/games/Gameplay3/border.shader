shader_type spatial;
render_mode unshaded, cull_front;

uniform vec4 color : hint_color = vec4(0, 1, 0, 1);
uniform float weight = 1.03;

void vertex() {
// Input:2
	vec3 n_out2p0 = VERTEX;

// VectorOp:3
	vec3 n_out3p0 = n_out2p0 * weight;

// Output:0
	VERTEX = n_out3p0;

}

void fragment() {
// Output:0
	ALBEDO = color.rgb;
	EMISSION = color.rgb;
}

void light() {
// Output:0

}
