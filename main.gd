extends Node

@onready var ui: UI = $UI
@onready var background_color: ColorRect = $BackgroundColor

func _ready() -> void:
	get_window().size = Global.game_resolution
	get_window().mode = Window.MODE_FULLSCREEN if Global.fullscreen else Window.MODE_WINDOWED
	get_window().move_to_center()

func _on_intro_finished() -> void:
	background_color.color = Color("4d4d4d")
	$AspectRatioContainer.queue_free()
	Signals.request_main_menu.emit()
	ui.visible = true
