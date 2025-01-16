class_name Game extends Control

#region VARIABLES
const BOARD_4 = preload("res://Game/Boards/Board4/board_4.tscn")

var players: Array[Node]

var _player_index: int = 0
var _bot_delay: int

var game_ended: bool = false
#endregion

#region SETUP FUNCTIONS
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
			var player: Actor = Bot.new() if player_data["is_bot"] else Player.new()
			player.color = player_data["color"]
			player.texture = Global.player_color_pawns[player.color]
			player.game = self
			player.add_to_group("Players")
			add_child(player)
		else:
			printerr("Player " + str(i+1) + " expects values that are missing!")
	add_child(board)
	for player: Actor in players:
		player.moved.connect(_on_player_moved)

func setup_local_multiplayer(_game_data: Dictionary) -> void:
	pass

func setup_online_multiplayer(_game_data: Dictionary) -> void:
	pass
#endregion

#region RUNTIME FUNCTIONS
func _process(_delta: float) -> void:
	manage_game_events()
	manage_turns()

func manage_game_events() -> void:
	if game_ended:
		get_tree().free()

func manage_turns() -> void:
	var player: Actor = players[_player_index]
	
	if player.can_move and player.finished_moving :
		_player_index = (_player_index + 1) % players.size()
		player.can_move = false
		player.finished_moving = false
	elif player.can_move and not player.finished_moving:
		pass
	elif not player.can_move and player.finished_moving:
		pass
	elif not player.can_move and not player.finished_moving:
		if player is Bot: 
			if _bot_delay < 0:
				player.can_move = true
				_bot_delay = randi_range(45, 100)
			else:
				_bot_delay -= 1
		else:
			player.can_move = true

func _on_player_moved(actor: Actor, tile: TextureRect) -> void:
	for player: Actor in players:
		if tile == player.standing_tile and not player == actor:
			players.erase(player)
			player.queue_free()
			break
#endregion
