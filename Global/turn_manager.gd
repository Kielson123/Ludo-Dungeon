extends Node

var turns: Array[Actor]

var current_turn_index: int = 0

func set_next_turn() -> void:
	current_turn_index = (current_turn_index + 1) % turns.size()

func get_turn() -> Actor:
	return turns[current_turn_index]
