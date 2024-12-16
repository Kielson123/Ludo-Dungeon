class_name Bot extends Node2D

@export var color: StringName
@export var starting_tile: TextureRect
@export var texture: Texture2D

var board_tiles: Array[TextureRect]
var sprite2d: Sprite2D

func _ready() -> void:
	var sprite := Sprite2D.new()
	sprite2d = sprite
	add_child(sprite)

func _process(_delta: float) -> void:
	sprite2d.texture = texture

func move(tiles: Array[TextureRect], amount: int) -> void:
	var current_tile: TextureRect = get_parent()
	var destination_tile: TextureRect = current_tile
	var current_tile_index: int = tiles.find(current_tile)
	
	var tile_number: int = current_tile_index + amount
	if tile_number > 39:
		tile_number = (tile_number % 39) - 1
	
	destination_tile = tiles[tile_number]
	reparent(destination_tile, false)
