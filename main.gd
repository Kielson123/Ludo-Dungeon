extends Node

@onready var ui: UI = $UI
@onready var background_color: ColorRect = $BackgroundColor

func _ready() -> void:
	get_window().size = Global.game_resolution

func _on_intro_finished() -> void:
	background_color.color = Color("4d4d4d")
	$AspectRatioContainer.queue_free()
	Signals.request_main_menu.emit()
	ui.visible = true
