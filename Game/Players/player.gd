class_name Player extends Node2D

@export var color: StringName
@export var starting_tile: TextureRect
@export var texture: Texture2D

var sprite2d: Sprite2D
var mouse_hovered: bool = false

func _ready() -> void:
	var sprite := Sprite2D.new()
	sprite2d = sprite
	add_child(sprite)

func _process(_delta: float) -> void:
	var is_mouse_hovered_x: bool = get_local_mouse_position().x >= position.x - 52 and get_local_mouse_position().x <= position.x - 3
	var is_mouse_hovered_y: bool = get_local_mouse_position().y >= position.y - 52 and get_local_mouse_position().y <= position.y - 3
	if is_mouse_hovered_x and is_mouse_hovered_y:
		mouse_hovered = true
	else:
		mouse_hovered = false
	sprite2d.texture = texture

func move(tiles: Array[TextureRect], amount: int) -> void:
	var current_tile: TextureRect = get_parent()
	var destination_tile: TextureRect = current_tile
	for i in range(tiles.size()):
		var tile_number: int = i + amount
		if tile_number > 39:
			tile_number = (tile_number % 39) - 1
		if tiles[i] == current_tile:
			destination_tile = tiles[tile_number]
			break
	if destination_tile == current_tile:
		printerr("Cannot move to the specified tile!")
		return
	reparent(destination_tile, false)
