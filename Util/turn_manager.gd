extends Node

var turns: Array[Actor]

var current_turn_index: int

func set_next_turn() -> void:
	pass

func get_turn() -> Actor:
	return turns[current_turn_index]
