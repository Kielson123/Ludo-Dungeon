class_name Actor extends Node

@export var nickname: String = ""

var pawns: Array[Pawn]

func _ready() -> void:
	for child in get_children():
		if child is Pawn:
			pawns.append(child)
