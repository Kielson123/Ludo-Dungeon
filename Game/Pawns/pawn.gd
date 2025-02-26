class_name Pawn extends Node2D

#region VARIABLES
signal moved(pawn: Pawn, tile: TextureRect)

@export var color: StringName
@export var starting_tile: TextureRect
@export var texture: Texture2D
@export var board_tiles: Array[TextureRect]
@export var game: Game
@export var can_move: bool
@export var finished_moving: bool
@export var standing_tile: TextureRect

@warning_ignore("unused_private_class_variable") var _destination_tile: TextureRect
@warning_ignore("unused_private_class_variable") var _sprite2d: Sprite2D
#endregion

#region SETUP FUNCTIONS
func _ready() -> void:
	_sprite2d = Sprite2D.new()
	add_child(_sprite2d)
#endregion

#region UTIL FUNCTIONS
func move(destination_tile: TextureRect) -> void:
	moved.emit(self, destination_tile)
	reparent(destination_tile, false)
	standing_tile = destination_tile
	finished_moving = true
#endregion
