extends Node

@onready var main: Main = Global.main_scene

func _ready() -> void:
	Signals.request_game_start.connect(on_game_start)

func on_game_start(game_type: Global.GAME_TYPE, data: Dictionary) -> void:
	main.ui.set_visible(false)
	main.game.set_visible(true)
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
	

func setup_local_multiplayer(game_data: Dictionary) -> void:
	pass

func setup_online_multiplayer(game_data: Dictionary) -> void:
	pass
