extends Node

signal ally_turn_started()
signal enemy_turn_starter()

enum Turn {
	ALLY, 
	ENEMY
}

var turn: Turn

func set_turn(turn_type: Turn) -> void:
	turn = turn_type
	match turn:
		Turn.ALLY: 
			ally_turn_started.emit()
		Turn.ENEMY: 
			enemy_turn_starter.emit()

func get_turn() -> Turn:
	return turn
