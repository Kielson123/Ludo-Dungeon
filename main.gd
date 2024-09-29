extends Node

@onready var ui: UI = $UI
@onready var background_color: ColorRect = $BackgroundColor

func _ready() -> void:
	Signals.settings_changed.connect(on_settings_changed)

func on_settings_changed() -> void:
	get_window().borderless = false
	get_window().mode = set_window_mode()
	DisplayServer.window_set_vsync_mode(Global.vsync)
	Engine.max_fps = Global.max_fps

func _on_intro_finished() -> void:
	background_color.color = Color("4d4d4d")
	$AspectRatioContainer.queue_free()
	Signals.request_main_menu.emit()
	ui.visible = true

func set_window_mode() -> Window.Mode:
	var mode := Global.SCREEN_MODE 
	match Global.screen_mode:
		mode.FULLSCREEN:
			return Window.MODE_EXCLUSIVE_FULLSCREEN
		mode.BORDERLESS:
			return Window.MODE_FULLSCREEN
		_:
			get_window().size = DisplayServer.screen_get_size() / 2
			get_window().move_to_center()
			return Window.MODE_WINDOWED
