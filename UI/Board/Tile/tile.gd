class_name Tile extends TextureButton

signal tile_pressed(tile: Tile, type: Type)

enum Type {
	NORMAL,
	RED,
	GREEN,
	BLUE,
	YELLOW,
	ORANGE,
	PURPLE,
}

@onready var color_rect: ColorRect = $ColorRect

@export var type: Type = Type.NORMAL
@export var index: int

func _ready() -> void:
	match type:
		Type.RED:
			self_modulate = Color(0.957, 0.0, 0.0, 1.0)
		Type.GREEN:
			self_modulate = Color(0.247, 0.812, 0.0, 1.0)
		Type.BLUE:
			self_modulate = Color(0.0, 0.167, 0.811, 1.0)
		Type.YELLOW:
			self_modulate = Color(0.92, 0.897, 0.0, 1.0)
		Type.ORANGE:
			self_modulate = Color(0.961, 0.557, 0.0, 1.0)
		Type.PURPLE:
			self_modulate = Color(0.579, 0.16, 0.781, 1.0)
		_:
			self_modulate = Color(0.953, 0.953, 0.953, 1.0)

func set_every_texture(texture_path: String) -> void:
	texture_normal = load(texture_path)
	texture_pressed = load(texture_path)
	texture_hover = load(texture_path)
	texture_disabled = load(texture_path)
	texture_focused = load(texture_path)

func _on_pressed() -> void:
	tile_pressed.emit(self, type)
