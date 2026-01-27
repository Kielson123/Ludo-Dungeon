class_name Actor extends Node

@export var color: Global.Colors = Global.Colors.NONE
@export var pawn_path: Array[int]
@export var pawns: Array[Pawn]

var selected_pawn: Pawn

func _process(_delta: float) -> void:
	if not pawns.is_empty() and pawns[0].color == Global.Colors.NONE:
		for pawn in pawns:
			pawn.set_color(color)
