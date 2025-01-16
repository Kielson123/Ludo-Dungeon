class_name Game extends Control

const BOARD_4 = preload("res://Game/Boards/Board4/board_4.tscn")
var moves_per_player: int
var total_moves_per_turn: int
var total_moves: int
var players: Array[Node]
var player_index: int = 0

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
	moves_per_player = game_data["turns_per_player"]
	for i in range(type):
		var player_data: Dictionary = game_data["player" + str(i+1)]
		if player_data.has_all(["color", "is_bot"]):
			var actor: Actor
			if player_data["is_bot"]:
				actor = Bot.new()
				actor.add_to_group("Players")
				actor.texture = load("res://Assets/Game/Pawns/default.svg")
				add_child(actor)
			else:
				actor = Player.new()
				actor.add_to_group("Players")
				actor.texture = load("res://Assets/Game/Pawns/default.svg")
				add_child(actor)
			actor.color = player_data["color"]
			actor.remaining_moves = 1
			total_moves_per_turn += moves_per_player
		else:
			printerr("Player " + str(i+1) + " expects values that are missing!")
	add_child(board)
	players = get_tree().get_nodes_in_group("Players")
	total_moves = total_moves_per_turn * moves_per_player

func setup_local_multiplayer(_game_data: Dictionary) -> void:
	pass

func setup_online_multiplayer(_game_data: Dictionary) -> void:
	pass

func _process(delta: float) -> void:
	var actor: Actor = players[player_index]
	if total_moves == total_moves_per_turn * moves_per_player and actor.remaining_moves == 0:
		actor.remaining_moves = moves_per_player
	
	if actor.remaining_moves == 0:
		actor.remaining_moves = moves_per_player
		player_index = (player_index + 1) % players.size()
	
	 if total_moves == 0:
		total_moves = total_moves_per_turn * moves_per_player
		
