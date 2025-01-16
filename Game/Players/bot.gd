class_name Bot extends Actor

var _sprite2d: Sprite2D
var _destination_tile: TextureRect

func _ready() -> void:
	var sprite := Sprite2D.new()
	_sprite2d = sprite
	add_child(sprite)

func _process(_delta: float) -> void:
	_sprite2d.texture = texture
	
	if remaining_moves > 0:
		var amount: int = randi_range(1, 6)
		var current_tile_index: int = board_tiles.find(get_parent())
		var tile_number: int = current_tile_index + amount
		if tile_number > 39:
			tile_number = (tile_number % 39) - 1
		_destination_tile = board_tiles[tile_number]
	
	move(_destination_tile)

func move(destination_tile: TextureRect) -> void:
	reparent(destination_tile, false)
	remaining_moves -= 1
	Global.main_scene.game.total_moves -= 1
