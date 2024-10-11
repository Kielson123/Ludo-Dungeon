extends Node

func _ready() -> void:
	Signals.request_game_start.connect(on_game_start)

func on_game_start() -> void:
	Global.main_scene.ui.set_visible(false)
