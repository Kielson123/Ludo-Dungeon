shader_type canvas_item;

uniform bool active = false;

void fragment() {
	vec4 new_color = texture(TEXTURE, UV);
	if (active == true)
	{
		new_color.a *= clamp(tan(TIME * 6.0) + 0.25, 0.65, 0.85);
	}
	COLOR = new_color;
}