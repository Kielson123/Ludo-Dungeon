class_name Pawn extends Node2D

@export var pawn_texture: Texture2D = preload("res://Assets/Game/Pawns/default.svg")

func move_to_tile(tile: Tile) -> void:
	var marker = tile.get_marker()
	position = marker.position


func can_move_to_tile(tile: Tile) -> bool:
	return true
