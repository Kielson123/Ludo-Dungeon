class_name Game extends Node2D

const BOARD_4 = preload("res://Game/Boards/Board4/board_4.tscn")

func _ready() -> void:
	Signals.request_game_start.connect(on_game_start)

func on_game_start(game_type: Global.GAME_TYPE, data: Dictionary) -> void:
	set_visible(true)
	match game_type:
		Global.GAME_TYPE.SINGLEPLAYER:
			setup_singleplayer(data)
		Global.GAME_TYPE.LOCAL_MULTIPLAYER:
			setup_local_multiplayer(data)
		Global.GAME_TYPE.ONLINE_MULTIPLAYER:
			setup_online_multiplayer(data)
	

func setup_singleplayer(game_data: Dictionary) -> void:
	var bot_number: int = game_data["bots"]
	var player_number: int = game_data["players"]
	var board: Board
	match (bot_number + player_number):
		4:
			board = BOARD_4.instantiate()
		_:
			board = BOARD_4.instantiate()
	add_child(board)

func setup_local_multiplayer(_game_data: Dictionary) -> void:
	pass

func setup_online_multiplayer(_game_data: Dictionary) -> void:
	pass
