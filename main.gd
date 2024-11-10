class_name Main extends Node

@onready var game: Node2D = $CenterContainer/Control/Game
@onready var ui: UI = $UI

var dev_mode: bool = false
var intro_finished: bool = false

func _init() -> void:
	Global.main_scene = self

func _on_intro_finished() -> void:
	intro_finished = true
	$AspectRatioContainer.queue_free()
	if dev_mode and OS.is_debug_build():
		Signals.request_game_start.emit(Global.GAME_TYPE.SINGLEPLAYER, {
			"bots": 3,
			"players": 1
		})
	else:
		Signals.request_main_menu.emit()
	ui.visible = true

func _ready() -> void:
	get_tree().auto_accept_quit = false

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		ConfigManager.save_all_settings()
		get_tree().quit()
	if what == NOTIFICATION_APPLICATION_PAUSED:
		ConfigManager.save_all_settings()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_backspace") and not intro_finished:
		dev_mode = true
