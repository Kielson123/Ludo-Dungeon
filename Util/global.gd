extends Node

const CONFIG_PATH: String = "user://config.cfg"

var game_resolution := Vector2(1280, 720)
var fullscreen: bool = true
var max_fps: int = 60

var audio_volume: float = 1.0

func _init() -> void:
	var config := ConfigFile.new()
	var err := config.load(CONFIG_PATH)
	if err == OK:
		game_resolution = config.get_value("DisplayOptions", "resolution")
		fullscreen = config.get_value("DisplayOptions", "fullscreen")
		max_fps = config.get_value("DisplayOptions", "maxFPS")
		audio_volume = config.get_value("AudioOptions", "audio_volume")
	else:
		config.set_value("DisplayOptions", "resolution", game_resolution)
		config.set_value("DisplayOptions", "fullscreen", fullscreen)
		config.set_value("DisplayOptions", "maxFPS", max_fps)
		config.set_value("AudioOptions", "audio_volume", audio_volume)
		config.save(CONFIG_PATH)
		_ready()
