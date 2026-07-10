class_name Pawn extends Node2D

signal pressed(pawn: Pawn)

enum Class{
	WARRIOR,
	MAGE,
	ROGUE,
	ARCHER
}

@onready var _texture: Sprite2D = $Sprite2D

@export var color: Global.Colors = Global.Colors.NONE
@export var pawn_class: Class = Class.WARRIOR
@export var in_spawn: bool = false
@export var path_index: int

func _ready() -> void:
	_texture.self_modulate = Global.get_rgb_from_color(color)

func set_color(new_color: Global.Colors) -> void:
	color = new_color
	_texture.self_modulate = Global.get_rgb_from_color(new_color)

func move(new_position: Vector2) -> void:
	set_position(new_position)

func activate_ability() -> void:
	match pawn_class:
		Class.WARRIOR:
			TurnManager.continue_current_turn()
		_:
			TurnManager.set_next_turn()

func set_selection_blink(active: bool) -> void:
	if active:
		_texture.set_material(preload("res://Assets/Game/Pawns/blinking.tres"))
	else:
		_texture.set_material(ShaderMaterial.new())

func _on_button_pressed() -> void:
	set_selection_blink(false)
	pressed.emit(self)
	print("cwel")
