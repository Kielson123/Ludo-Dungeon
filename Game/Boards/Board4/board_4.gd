class_name Board4 extends Board

@export var blank_space_length: int = 2

func _ready() -> void:
	for tile_container: Container in get_tree().get_nodes_in_group("TileContainers"):
		if tile_container is BoxContainer:
			tile_container.add_theme_constant_override("separation", blank_space_length)
		elif tile_container is GridContainer:
			tile_container.add_theme_constant_override("h_separation", blank_space_length)
			tile_container.add_theme_constant_override("v_separation", blank_space_length)
	
	var players: Array[Node] = get_tree().get_nodes_in_group("Players")
	for i in range(players.size()):
		starting_tiles[i].texture = Global.player_color_tiles[players[i].color]
		players[i].starting_tile = starting_tiles[i]
		players[i].reparent(starting_tiles[i])
		players[i].position = starting_tiles[i].size / 2

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_click"):
		var players: Array[Node] = get_tree().get_nodes_in_group("Players")
		for player in players:
			if player is Player and player.mouse_hovered:
				player.menu_opened = !player.menu_opened
