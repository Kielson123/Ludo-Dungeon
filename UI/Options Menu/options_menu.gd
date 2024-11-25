extends Control


@onready var max_fps_text: LineEdit = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Display/VBoxContainer/MaxFPS/HSplitContainer/LineEdit
@onready var max_fps_slider: HSlider = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Display/VBoxContainer/MaxFPS/HSplitContainer/HSlider



func _ready() -> void:
	$CenterContainer/MarginContainer/MarginContainer/TabContainer/Display/VBoxContainer/ScreenMode/OptionButton.select(ConfigManager.screen_mode)
	sync_max_fps()
	sync_volume(ConfigManager.AUDIO_TYPE.AUDIO)
	sync_volume(ConfigManager.AUDIO_TYPE.MUSIC)
	sync_volume(ConfigManager.AUDIO_TYPE.SFX)


func _on_screen_mode_changed(_index: int) -> void:
	ConfigManager.screen_mode = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Display/VBoxContainer/ScreenMode/OptionButton.get_selected_id()
	ConfigManager.save_settings("screenMode")


func _on_max_fps_text_submitted(new_text: String) -> void:
	if new_text.is_valid_int():
		ConfigManager.max_fps = maxi(new_text.to_int(), 0)
	sync_max_fps()
	ConfigManager.save_settings("maxFPS")
	max_fps_text.release_focus()


func _on_max_fps_slider_value_changed(value: float) -> void:
	ConfigManager.max_fps = maxi(int(value), 0)
	sync_max_fps()


func _on_max_fps_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigManager.save_settings("maxFPS")


func sync_max_fps() -> void:
	var max_fps: int = ConfigManager.max_fps
	if max_fps == 0:
		max_fps_text.text = "∞"
	else:
		max_fps_text.text = str(max_fps)
	max_fps_slider.set_value_no_signal(max_fps)


func _on_exit_button_pressed() -> void:
	Signals.request_main_menu.emit()


func _on_vsync_mode_changed(index: int) -> void:
	ConfigManager.vsync = clamp(index, 0, 2)
	ConfigManager.save_settings("vsync")


func _on_audio_volume_text_submitted(new_text: String) -> void:
	if new_text.is_valid_int():
		ConfigManager.audio_volume = clampi(new_text.to_int(), 0, 100)
	sync_volume(ConfigManager.AUDIO_TYPE.AUDIO)
	ConfigManager.save_settings("audioVolume")


func _on_audio_volume_slider_value_changed(value: float) -> void:
	ConfigManager.audio_volume = clampi(int(value), 0, 100)
	sync_volume(ConfigManager.AUDIO_TYPE.AUDIO)


func _on_audio_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigManager.save_settings("audioVolume")


func _on_music_volume_text_submitted(new_text: String) -> void:
	if new_text.is_valid_int():
		ConfigManager.music_volume = clampi(new_text.to_int(), 0, 100)
	sync_volume(ConfigManager.AUDIO_TYPE.MUSIC)
	ConfigManager.save_settings("musicVolume")


func _on_music_volume_slider_value_changed(value: float) -> void:
	ConfigManager.music_volume = clampi(int(value), 0, 100)
	sync_volume(ConfigManager.AUDIO_TYPE.MUSIC)


func _on_music_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigManager.save_settings("musicVolume")


func _on_sfx_volume_text_submitted(new_text: String) -> void:
	if new_text.is_valid_int():
		ConfigManager.sfx_volume = clampi(new_text.to_int(), 0, 100)
	sync_volume(ConfigManager.AUDIO_TYPE.SFX)
	ConfigManager.save_settings("sfxVolume")


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	ConfigManager.sfx_volume = clampi(int(value), 0, 100)
	sync_volume(ConfigManager.AUDIO_TYPE.SFX)


func _on_sfx_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigManager.save_settings("sfxVolume")


func sync_volume(type: ConfigManager.AUDIO_TYPE) -> void:
	var volume_text: LineEdit
	var volume_slider: HSlider
	var volume: int
	match type:
		ConfigManager.AUDIO_TYPE.MUSIC:
			volume = ConfigManager.music_volume
			volume_text = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Audio/VBoxContainer/MusicVolume/HSplitContainer/HSplitContainer/LineEdit
			volume_slider = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Audio/VBoxContainer/MusicVolume/HSplitContainer/HSlider
		ConfigManager.AUDIO_TYPE.SFX:
			volume = ConfigManager.sfx_volume
			volume_text = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Audio/VBoxContainer/SFXVolume/HSplitContainer/HSplitContainer/LineEdit
			volume_slider = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Audio/VBoxContainer/SFXVolume/HSplitContainer/HSlider
		_:
			volume = ConfigManager.audio_volume
			volume_text = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Audio/VBoxContainer/AudioVolume/HSplitContainer/HSplitContainer/LineEdit
			volume_slider = $CenterContainer/MarginContainer/MarginContainer/TabContainer/Audio/VBoxContainer/AudioVolume/HSplitContainer/HSlider
	volume_text.text = str(volume)
	volume_slider.set_value_no_signal(volume)
