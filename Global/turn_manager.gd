extends Node

signal turn_changed()

var turns: Array[Actor]

var current_turn_index: int = 0

func set_next_turn() -> void:
	current_turn_index = (current_turn_index + 1) % turns.size()
	turn_changed.emit()

func continue_current_turn() -> void:
	turn_changed.emit()

func get_turn() -> Actor:
	return turns[current_turn_index]
