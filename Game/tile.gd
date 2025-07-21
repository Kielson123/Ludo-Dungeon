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

@export var type: Type = Type.NORMAL

func _ready() -> void:
	match type:
		Type.RED:
			set_every_texture("res://Assets/Game/Tiles/red_tile.png")
		Type.GREEN:
			set_every_texture("res://Assets/Game/Tiles/green_tile.png")
		Type.BLUE:
			set_every_texture("res://Assets/Game/Tiles/blue_tile.png")
		Type.YELLOW:
			set_every_texture("res://Assets/Game/Tiles/yellow_tile.png")
		Type.ORANGE:
			set_every_texture("res://Assets/Game/Tiles/orange_tile.png")
		Type.PURPLE:
			set_every_texture("res://Assets/Game/Tiles/purple_tile.png")
		_:
			set_every_texture("res://Assets/Game/Tiles/tile.png")

func set_every_texture(texture_path: String) -> void:
	texture_normal = load(texture_path)
	texture_pressed = load(texture_path)
	texture_hover = load(texture_path)
	texture_disabled = load(texture_path)
	texture_focused = load(texture_path)

func _on_pressed() -> void:
	tile_pressed.emit(self, type)
