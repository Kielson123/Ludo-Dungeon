class_name Actor extends Node

@export var color: Global.Colors
@export var pawn_path: Array[int]
@export var pawns: Array[Pawn]

var selected_pawn: Pawn

func _input(event: InputEvent) -> void:
	selected_pawn = pawns[0]
	if event.is_action_pressed(&"ui_down"):
		if selected_pawn.path_index + 1 >= 52:
			Global.game_won.emit(self)
		selected_pawn.path_index += 1
