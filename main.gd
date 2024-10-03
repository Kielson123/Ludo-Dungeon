extends Node

@onready var ui: UI = $UI
@onready var background_color: ColorRect = $BackgroundColor

func _on_intro_finished() -> void:
	background_color.color = Color("4d4d4d")
	$AspectRatioContainer.queue_free()
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
