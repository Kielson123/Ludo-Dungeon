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
var resolution: Vector2i = Vector2i.ZERO

var audio_volume: int = 100
var music_volume: int = 100
var sfx_volume: int = 100

var config := ConfigFile.new()

func _init() -> void:
	var err := config.load(CONFIG_PATH)
	if err == OK:
		screen_mode = config.get_value("Display", "screenMode") if config.has_section_key("Display", "screenMode") else screen_mode
		max_fps = config.get_value("Display", "maxFPS") if config.has_section_key("Display", "maxFPS") else max_fps
		vsync = config.get_value("Display", "vsync") if config.has_section_key("Display", "vsync") else vsync
		resolution = config.get_value("Display", "resolution") if config.has_section_key("Display", "resolution") else resolution
		
		audio_volume = config.get_value("Audio", "audioVolume") if config.has_section_key("Audio", "audioVolume") else audio_volume
		music_volume = config.get_value("Audio", "musicVolume") if config.has_section_key("Audio", "musicVolume") else music_volume
		sfx_volume = config.get_value("Audio", "sfxVolume") if config.has_section_key("Audio", "sfxVolume") else sfx_volume


func _ready() -> void:
	call_deferred("init_settings")


func init_settings() -> void:
	configure_audio()
	get_window().mode = set_window_mode()
	if resolution != Vector2i.ZERO and screen_mode == SCREEN_MODE.WINDOWED:
		get_window().size = resolution
		get_window().move_to_center()
	DisplayServer.window_set_vsync_mode(vsync)
	Engine.max_fps = max_fps


func _process(_delta: float) -> void:
	if get_window().mode == Window.MODE_WINDOWED:
		resolution = get_window().size
	else:
		resolution = Vector2i.ZERO


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
			value = max_fps
			Engine.max_fps = max_fps
		"vsync":
			category = "Display"
			value = vsync
			DisplayServer.window_set_vsync_mode(vsync)
		"resolution":
			category = "Display"
			value = get_window().size if get_window().mode == Window.MODE_WINDOWED else Vector2i.ZERO
			if resolution != Vector2i.ZERO:
				get_window().size = resolution 
				get_window().move_to_center()
		
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
			if resolution != Vector2i.ZERO:
				return Window.MODE_WINDOWED
			else:
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


func save_all_settings() -> void:
	save_settings("screenMode")
	save_settings("maxFPS")
	save_settings("vsync")
	save_settings("resolution")
	save_settings("audioVolume")
	save_settings("musicVolume")
	save_settings("sfxVolume")
