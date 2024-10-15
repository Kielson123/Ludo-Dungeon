class_name Main extends Node

@export var boot_into_game_with_bots: bool = false

@onready var game: Node2D = $Game
@onready var ui: UI = $UI
@onready var background_color: ColorRect = $BackgroundColor

func _init() -> void:
	Global.main_scene = self

func _on_intro_finished() -> void:
	background_color.color = Color("4d4d4d")
	$AspectRatioContainer.queue_free()
	if boot_into_game_with_bots:
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
