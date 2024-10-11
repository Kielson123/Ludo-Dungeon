extends Control



func _on_singleplayer_mode_button_pressed() -> void:
	Signals.request_game_start.emit()


func _on_multiplayer_mode_button_pressed() -> void:
	#open MultiplayerOptionsMenu
	pass


func _on_options_button_pressed() -> void:
	Signals.request_options_menu.emit()


func _on_exit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
