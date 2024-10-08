extends Control

@onready var bot_count_input: LineEdit = $"MarginContainer/VBoxContainer/PanelContainer/MarginContainer/HSplitContainer/VSplitContainer/GameOptionsContainer/Bot Count Option/LineEdit"

var max_player_count: int = 4

func _on_exit_button_pressed() -> void:
	Signals.request_main_menu.emit()


func _on_line_edit_text_changed(new_text: String) -> void:
	var count: int = clamp(int(bot_count_input.text), 0, max_player_count - 1)
	bot_count_input.text = str(count)
