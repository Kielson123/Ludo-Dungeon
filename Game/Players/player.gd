class_name Player extends Node2D

@export var color: StringName
@export var starting_tile: TextureRect
@export var texture: Texture2D

var sprite2d: Sprite2D

func _ready() -> void:
	var sprite := Sprite2D.new()
	sprite2d = sprite
	add_child(sprite)

func _process(_delta: float) -> void:
	sprite2d.texture = texture
