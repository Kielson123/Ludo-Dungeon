class_name Tile extends TextureButton

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
			texture_normal = load("res://Assets/Game/Tiles/red_tile.png")
		Type.GREEN:
			texture_normal = load("res://Assets/Game/Tiles/green_tile.png")
		Type.BLUE:
			texture_normal = load("res://Assets/Game/Tiles/blue_tile.png")
		Type.YELLOW:
			texture_normal = load("res://Assets/Game/Tiles/yellow_tile.png")
		Type.ORANGE:
			texture_normal = load("res://Assets/Game/Tiles/orange_tile.png")
		Type.PURPLE:
			texture_normal = load("res://Assets/Game/Tiles/purple_tile.png")
		_:
			texture_normal = load("res://Assets/Game/Tiles/tile.png")
