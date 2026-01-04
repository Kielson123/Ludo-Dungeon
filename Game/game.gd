class_name Game extends Control

func _ready() -> void:
	Signals.tile_pressed.connect(_on_tile_pressed)

func _on_tile_pressed(tile_index: int) -> void:
	pass
