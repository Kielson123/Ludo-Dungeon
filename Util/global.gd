extends Node

enum SCREEN_MODE{
	WINDOWED = 0,
	FULLSCREEN = 1, 
	BORDERLESS = 2,
}

const CONFIG_PATH: String = "user://config.cfg"

var screen_mode: SCREEN_MODE = SCREEN_MODE.WINDOWED
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

func init_settings() -> void:
	Signals.settings_changed.emit()

func _ready() -> void:
	call_deferred("init_settings")
