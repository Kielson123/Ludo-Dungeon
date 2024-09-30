extends Node

enum SCREEN_MODE{
	WINDOWED = 0,
	FULLSCREEN = 1, 
	BORDERLESS = 2,
}

const CONFIG_PATH: String = "user://config.cfg"

var screen_mode: SCREEN_MODE = SCREEN_MODE.FULLSCREEN
var max_fps: int = 0
var vsync: DisplayServer.VSyncMode = DisplayServer.VSYNC_ENABLED

var audio_volume: float = 1.0

var config := ConfigFile.new()

func _init() -> void:
	var err := config.load(CONFIG_PATH)
	if err == OK:
		screen_mode = config.get_value("Display", "screenMode")
		max_fps = config.get_value("Display", "maxFPS")
		vsync = config.get_value("Display", "vsync")
		
		audio_volume = config.get_value("Audio", "audioVolume")

func _ready() -> void:
	call_deferred("init_settings")

func init_settings() -> void:
	get_window().mode = set_window_mode()
	DisplayServer.window_set_vsync_mode(vsync)
	Engine.max_fps = max_fps

func save_settings(setting: String) -> void:
	var category: String
	var value: Variant
	
	match setting:
		"screenMode":
			category = "Display"
			value = screen_mode
			get_window().mode = set_window_mode()
		"maxFPS":
			category = "Display"
			value = screen_mode
			Engine.max_fps = max_fps
		"vsync":
			category = "Display"
			value = vsync
			DisplayServer.window_set_vsync_mode(vsync)
		
		"audioVolume":
			category = "Audio"
			value = audio_volume
	
	
	if category != null and value != null:
		config.set_value(category, setting, value)
		config.save(CONFIG_PATH)

func set_window_mode() -> Window.Mode:
	match screen_mode:
		SCREEN_MODE.WINDOWED:
			return Window.MODE_MAXIMIZED
		SCREEN_MODE.BORDERLESS:
			return Window.MODE_FULLSCREEN
		_:
			return Window.MODE_EXCLUSIVE_FULLSCREEN
