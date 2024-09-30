extends Node

enum AUDIO_TYPE{
	AUDIO = 0,
	MUSIC = 1,
	SFX = 2,
}

enum SCREEN_MODE{
	WINDOWED = 0,
	FULLSCREEN = 1, 
	BORDERLESS = 2,
}

const CONFIG_PATH: String = "user://config.cfg"

var screen_mode: SCREEN_MODE = SCREEN_MODE.FULLSCREEN
var max_fps: int = 0
var vsync: DisplayServer.VSyncMode = DisplayServer.VSYNC_ADAPTIVE

var audio_volume: int = 100
var music_volume: int = 100
var sfx_volume: int = 100

var config := ConfigFile.new()

func _init() -> void:
	var err := config.load(CONFIG_PATH)
	if err == OK:
		screen_mode = config.get_value("Display", "screenMode")
		max_fps = config.get_value("Display", "maxFPS")
		vsync = config.get_value("Display", "vsync")
		
		audio_volume = config.get_value("Audio", "audioVolume")
		music_volume = config.get_value("Audio", "musicVolume")
		sfx_volume = config.get_value("Audio", "sfxVolume")

func _ready() -> void:
	call_deferred("init_settings")

func init_settings() -> void:
	configure_audio()
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
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(float(value) / 100))
		"musicVolume":
			category = "Audio"
			value = music_volume
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(float(value) / 100))
		"sfxVolume":
			category = "Audio"
			value = sfx_volume
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(float(value) / 100))
	
	
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

func configure_audio() -> void:
	AudioServer.add_bus(1)
	AudioServer.add_bus(2)
	
	AudioServer.set_bus_name(1, "Music")
	AudioServer.set_bus_name(2, "SFX")
	
	AudioServer.set_bus_volume_db(0, linear_to_db(float(audio_volume) / 100))
	AudioServer.set_bus_volume_db(1, linear_to_db(float(music_volume) / 100))
	AudioServer.set_bus_volume_db(2, linear_to_db(float(sfx_volume) / 100))
