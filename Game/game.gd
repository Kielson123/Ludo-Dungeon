class_name Game extends Control

@onready var pawn: Pawn = $Pawn

func _ready() -> void:
	Signals.tile_pressed.connect(_on_tile_pressed)

func _on_tile_pressed(tile_index: int) -> void:
	var tile_position: Vector2 = get_tile_position(tile_index)
	pawn.position = tile_position

func get_tile_position(tile_index: int) -> Vector2:
	for marker in $TileMarkers.get_children():
		if marker.index == tile_index:
			return marker.position
	return Vector2(0, 0)
