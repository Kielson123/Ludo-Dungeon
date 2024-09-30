extends Control


func _on_singleplayer_mode_button_pressed() -> void:
	Signals.request_singleplayer_start_menu.emit()

func _on_multiplayer_mode_button_pressed() -> void:
	#open MultiplayerOptionsMenu
	pass

func _on_options_button_pressed() -> void:
	Signals.request_options_menu.emit()

func _on_exit_button_pressed() -> void:
	get_tree().quit()
