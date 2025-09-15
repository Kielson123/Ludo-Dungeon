class_name Pawn extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var pawn_texture: Texture2D = preload("res://Assets/Game/Pawns/default.svg")

func _ready() -> void:
	sprite_2d.texture = pawn_texture

func move_to_tile(tile: Tile) -> void:
	var marker = tile.get_marker()
	position = marker.position

func can_move_to_tile(tile: Tile) -> bool:
	return true
