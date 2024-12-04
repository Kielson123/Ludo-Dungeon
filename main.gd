class_name Main extends Node

@onready var game: Control = $Control/Game
@onready var ui: UI = $UI

@export var dev_mode: bool = true
var intro_finished: bool = false

func _init() -> void:
	Global.main_scene = self

func _on_intro_finished() -> void:
	intro_finished = true
	$IntroContainer.queue_free()
	if dev_mode:
		Signals.request_game_start.emit(Global.GAME_TYPE.SINGLEPLAYER, {
			"bots": 3,
			"players": 1,
			"player1": {
				"color": Global.player_colors.pick_random()
			},
			"player2": {
				"color": Global.player_colors.pick_random()
			},
			"player3": {
				"color": Global.player_colors.pick_random()
			},
			"player4": {
				"color": Global.player_colors.pick_random()
			}
		})
	else:
		Signals.request_main_menu.emit()
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
