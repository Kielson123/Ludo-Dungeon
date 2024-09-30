extends Control


func _on_exit_button_pressed() -> void:
	Signals.request_main_menu.emit()
