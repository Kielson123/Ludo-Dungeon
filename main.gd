class_name Main extends Node

@onready var game: Control = $Game
@onready var ui: UI = $UI

@export var dev_mode: bool = true
var intro_finished: bool = false

func _init() -> void:
	Global.main_scene = self

func _on_intro_finished() -> void:
	intro_finished = true
	$IntroContainer.queue_free()
	if dev_mode:
		Global.request_game_start.emit(Global.GAME_TYPE.SINGLEPLAYER, {
			"type": 4,
			"player1": {
				"is_bot": false,
				"color": Global.player_colors.pick_random()
			},
			"player2": {
				"is_bot": true,
				"color": Global.player_colors.pick_random()
			},
			"player3": {
				"is_bot": true,
				"color": Global.player_colors.pick_random()
			},
			"player4": {
				"is_bot": true,
				"color": Global.player_colors.pick_random()
			},
			"turns_per_player": 1
		})
	else:
		Global.request_main_menu.emit()
	ui.visible = true

func _ready() -> void:
	if dev_mode:
		$IntroContainer/AspectRatioContainer/Intro.finished.emit()
	get_tree().auto_accept_quit = false

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		ConfigManager.save_all_settings()
		get_tree().quit()
	if what == NOTIFICATION_APPLICATION_PAUSED:
		ConfigManager.save_all_settings()
