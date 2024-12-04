class_name Game extends Control

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
	var board_size: Vector2 = Global.main_scene.ui.size
	match (bot_number + player_number):
		4:
			var player1: Dictionary = game_data["player1"] if game_data.has("player1") else {}
			var player2: Dictionary = game_data["player2"] if game_data.has("player2") else {}
			var player3: Dictionary = game_data["player3"] if game_data.has("player3") else {}
			var player4: Dictionary = game_data["player4"] if game_data.has("player4") else {}
			board = BOARD_4.instantiate()
			if player1.has_all(["color"]):
				board.player_data[0]["color"] = player1["color"]
			if player2.has_all(["color"]):
				board.player_data[1]["color"] = player2["color"]
			if player3.has_all(["color"]):
				board.player_data[2]["color"] = player3["color"]
			if player4.has_all(["color"]):
				board.player_data[3]["color"] = player4["color"]
	add_child(board)

func setup_local_multiplayer(_game_data: Dictionary) -> void:
	pass

func setup_online_multiplayer(_game_data: Dictionary) -> void:
	pass
