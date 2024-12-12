class_name Game extends Control

const BOARD_4 = preload("res://Game/Boards/Board4/board_4.tscn")

func _ready() -> void:
	Global.request_game_start.connect(on_game_start)

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
	var type: int = game_data["type"]
	var board: Board
	match type:
		4:
			board = BOARD_4.instantiate()
		_:
			printerr("Specified game type doesn't exist!")
	for i in range(type):
		var player_data: Dictionary = game_data["player" + str(i+1)]
		if player_data.has_all(["color", "is_bot"]):
			var player: Node
			if player_data["is_bot"]:
				player = Bot.new()
				player.add_to_group("Players")
				add_child(player)
			else:
				player = Player.new()
				player.add_to_group("Players")
				player.texture = load("res://Assets/Game/Pawns/default.svg")
				add_child(player)
			player.color = player_data["color"]
		else:
			printerr("Player " + str(i+1) + " expects values that are missing!")
	add_child(board)

func setup_local_multiplayer(_game_data: Dictionary) -> void:
	pass

func setup_online_multiplayer(_game_data: Dictionary) -> void:
	pass
