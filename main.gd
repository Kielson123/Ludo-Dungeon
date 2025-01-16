class_name Main extends Node

#region VARIABLES
@onready var game: Game = $Game
@onready var ui: UI = $UI

@export var dev_mode: bool = true
var _intro_finished: bool = false
#endregion

#region SETUP FUNCTIONS
func _init() -> void:
	Global.main_scene = self

func _on_intro_finished() -> void:
	_intro_finished = true
	$IntroContainer.queue_free()
	if dev_mode:
		var colors: Array[StringName] = Global.player_colors.duplicate()
		colors.shuffle()
		Global.request_game_start.emit(Global.GAME_TYPE.SINGLEPLAYER, {
			"type": 4,
			"player1": {
				"is_bot": false,
				"color": colors[0]
			},
			"player2": {
				"is_bot": true,
				"color": colors[1]
			},
			"player3": {
				"is_bot": true,
				"color": colors[2]
			},
			"player4": {
				"is_bot": true,
				"color": colors[3]
			}
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
#endregion
