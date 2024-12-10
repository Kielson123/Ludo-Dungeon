class_name Board4 extends Board

@export var blank_space_length: int = 2

var player_data: Array[Dictionary] = [{}, {}, {}, {}]

func _ready() -> void:
	for tile_container: Container in get_tree().get_nodes_in_group("TileContainers"):
		if tile_container is BoxContainer:
			tile_container.add_theme_constant_override("separation", blank_space_length)
		elif tile_container is GridContainer:
			tile_container.add_theme_constant_override("h_separation", blank_space_length)
			tile_container.add_theme_constant_override("v_separation", blank_space_length)
	
	for i in starting_tiles.size():
		starting_tiles[i].texture = Global.player_color_tiles[player_data[i]["color"]]
