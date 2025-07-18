extends Node

signal ally_turn_started()
signal enemy_turn_starter()

enum {
	ALLY_TURN, 
	ENEMY_TURN
}

var turn: int

func set_turn(turn_type: int) -> void:
	turn = turn_type
	match turn:
		ALLY_TURN: 
			ally_turn_started.emit()
		ENEMY_TURN: 
			enemy_turn_starter.emit()
