class_name Player extends Node2D

@export var color: StringName
@export var starting_tile: TextureRect
@export var texture: Texture2D
@export var board_tiles: Array[TextureRect]
@export var menu_opened: bool = false

var sprite2d: Sprite2D
var mouse_hovered: bool = false

var _previous_menu_opened: bool = false
var _destination_tile: TextureRect

func _ready() -> void:
	var sprite := Sprite2D.new()
	sprite2d = sprite
	add_child(sprite)

func _process(_delta: float) -> void:
	mouse_hovered = _is_mouse_hovered_player()
	sprite2d.texture = texture
	
	menu_opened = !menu_opened if Input.is_action_just_pressed("mouse_click") and mouse_hovered else menu_opened
	
	if menu_opened and not _previous_menu_opened: 
		var amount: int = randi_range(1, 6)
		var current_tile_index: int = board_tiles.find(get_parent())
		var tile_number: int = current_tile_index + amount
		if tile_number > 39:
			tile_number = (tile_number % 39) - 1
		_destination_tile = board_tiles[tile_number]
		_destination_tile.material.set_shader_parameter("active", true)
	elif not menu_opened and _previous_menu_opened:
		_destination_tile.material.set_shader_parameter("active", false)
	
	if menu_opened and _is_mouse_hovered_destination() and Input.is_action_just_pressed("mouse_click"):
		move(_destination_tile)
		menu_opened = false
		mouse_hovered = false
	_previous_menu_opened = menu_opened

func move(destination_tile: TextureRect) -> void:
	reparent(destination_tile, false)

func _is_mouse_hovered_player() -> bool:
	var is_mouse_hovered_x: bool = get_local_mouse_position().x >= position.x - 52 and get_local_mouse_position().x <= position.x - 3
	var is_mouse_hovered_y: bool = get_local_mouse_position().y >= position.y - 52 and get_local_mouse_position().y <= position.y - 3
	return is_mouse_hovered_x and is_mouse_hovered_y

func _is_mouse_hovered_destination() -> bool:
	var is_mouse_hovered_x: bool = _destination_tile.get_local_mouse_position().x >= position.x - 50 \
						and _destination_tile.get_local_mouse_position().x <= position.x
	var is_mouse_hovered_y: bool = _destination_tile.get_local_mouse_position().y >= position.y - 50 \
						and _destination_tile.get_local_mouse_position().y <= position.y
	return is_mouse_hovered_x and is_mouse_hovered_y
