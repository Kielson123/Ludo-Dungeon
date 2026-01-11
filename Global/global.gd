extends Node

signal tile_pressed(tile_index: int)

enum Colors {
	NONE,
	RED,
	GREEN,
	BLUE,
	YELLOW,
	ORANGE,
	PURPLE,
}

func get_rgb_from_color(color: Colors) -> Color:
	match color:
		Colors.RED: return Color(0.957, 0.0, 0.0, 1.0)
		Colors.GREEN: return Color(0.247, 0.812, 0.0, 1.0)
		Colors.BLUE: return Color(0.0, 0.167, 0.811, 1.0)
		Colors.YELLOW: return Color(0.92, 0.897, 0.0, 1.0)
		Colors.ORANGE: return Color(0.961, 0.557, 0.0, 1.0)
		Colors.PURPLE: return Color(0.579, 0.16, 0.781, 1.0)
		_: return Color(0.953, 0.953, 0.953, 1.0)
