class_name Player extends Actor

var is_turn: bool

func _on_tile_pressed(tile: Tile, type: Tile.Type) -> void:
	if is_turn:
		pawns[0].move_to_tile(tile)

func _physics_process(delta: float) -> void:
	is_turn =  TurnManager.get_turn() == self
