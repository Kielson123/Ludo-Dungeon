extends Control

@onready var line_edit: LineEdit = $MarginContainer/VSplitContainer/TabContainer/Display/VBoxContainer/MaxFPS/HSplitContainer/LineEdit
@onready var h_slider: HSlider = $MarginContainer/VSplitContainer/TabContainer/Display/VBoxContainer/MaxFPS/HSplitContainer/HSlider

func _ready() -> void:
	sync_max_fps()

func _on_screen_mode_changed(_index: int) -> void:
	ConfigManager.screen_mode = $MarginContainer/VSplitContainer/TabContainer/Display/VBoxContainer/ScreenMode/OptionButton.get_selected_id()
	ConfigManager.save_settings("screenMode")

func _on_max_fps_text_submitted(new_text: String) -> void:
	if new_text.is_valid_int():
		ConfigManager.max_fps = maxi(new_text.to_int(), 0)
	sync_max_fps()
	ConfigManager.save_settings("maxFPS")

func _on_max_fps_slider_value_changed(value: float) -> void:
	ConfigManager.max_fps = maxi(value, 0)
	sync_max_fps()

func _on_max_fps_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigManager.save_settings("maxFPS")

func sync_max_fps() -> void:
	var max_fps: int = ConfigManager.max_fps
	if max_fps == 0:
		line_edit.text = "∞"
	else:
		line_edit.text = str(max_fps)
	h_slider.set_value_no_signal(max_fps)

func _on_exit_button_pressed() -> void:
	Signals.request_main_menu.emit()

func _on_vsync_mode_changed(index: int) -> void:
	ConfigManager.vsync = clamp(index, 0, 2)
	ConfigManager.save_settings("vsync")
