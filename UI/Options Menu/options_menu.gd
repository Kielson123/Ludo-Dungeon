extends Control

func _on_desktop_options_changed() -> void:
	Global.screen_mode = Global.SCREEN_MODE.get($MarginContainer/TabContainer/Display/VBoxContainer/ScreenMode/OptionButton.get_selected_id()) 
	Signals.settings_changed.emit()
