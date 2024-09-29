class_name UI
extends Control

func _ready() -> void:
	Signals.request_main_menu.connect(on_main_menu_requested)
	Signals.request_options_menu.connect(on_options_menu_requested)

func on_main_menu_requested() -> void:
	var main_menu: Control = load("res://UI/Main Menu/main_menu.tscn").instantiate()
	close_all_nodes_in_group("Main Menu Incompatible")
	add_child(main_menu)

func on_options_menu_requested() -> void:
	var options_menu: Control = load("res://UI/Options Menu/options_menu.tscn").instantiate()
	close_all_nodes_in_group("Options Menu Incompatible")
	add_child(options_menu)

func close_all_nodes_in_group(group: StringName) -> void:
	for node: Node in get_tree().get_nodes_in_group(group):
		node.queue_free()
