class_name UI
extends Control

func _ready() -> void:
	Signals.request_main_menu.connect(on_main_menu_requested)

func on_main_menu_requested() -> void:
	var main_menu: Control = load("res://UI/main_menu.tscn").instantiate()
	close_all_nodes_in_group("Main Menu Incompatible")
	add_child(main_menu)

func close_all_nodes_in_group(group: StringName) -> void:
	for node: Node in get_tree().get_nodes_in_group(group):
		node.queue_free()
