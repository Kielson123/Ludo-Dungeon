class_name Bot extends Actor

#region RUNTIME FUNCTIONS
func _process(_delta: float) -> void:
	_sprite2d.texture = texture
	
	if can_move:
		var amount: int = randi_range(1, 6)
		var current_tile_index: int = board_tiles.find(get_parent())
		var tile_number: int = (current_tile_index + amount) % (board_tiles.size())
		_destination_tile = board_tiles[tile_number]
		move(_destination_tile)
#endregion
