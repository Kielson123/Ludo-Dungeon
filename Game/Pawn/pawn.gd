class_name Pawn extends Node2D

@onready var _texture: Sprite2D = $Sprite2D

@export var color: Global.Colors = Global.Colors.NONE
@export var in_spawn: bool = true
@export var path_index: int

func _ready() -> void:
	_texture.self_modulate = Global.get_rgb_from_color(color)

func set_color(new_color: Global.Colors) -> void:
	color = new_color
	_texture.self_modulate = Global.get_rgb_from_color(new_color)
