class_name Pawn extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var pawn_texture: Texture2D = preload("res://Assets/Game/Pawns/default.svg")
@export var tile: int

func _ready() -> void:
	sprite_2d.texture = pawn_texture
