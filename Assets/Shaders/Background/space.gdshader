shader_type canvas_item;

uniform vec2 stars_speed = vec2(0.0);
uniform float stars_density: hint_range(0.0, 1.0, 0.001) = 0.01;

varying vec2 position;

// https://thebookofshaders.com/10/
float random(vec2 st) {
	return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// Called for every vertex the material is visible on.
void vertex() {
	position = VERTEX;
}

// Called for every pixel the material is visible on.
void fragment() {
	vec2 uv = (position + TIME * stars_speed) * TEXTURE_PIXEL_SIZE;
	uv = fract(uv) * step(random(floor(uv)), stars_density);
	COLOR = texture(TEXTURE, uv);
}
