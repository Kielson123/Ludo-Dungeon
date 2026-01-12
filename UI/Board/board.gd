extends CenterContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer

@export var tiles: Array[Tile] = []

func _ready() -> void:
	Global.should_color_tiles.connect(_on_should_color_tiles)
	
	for h_box_container in v_box_container.get_children():
		for tile in h_box_container.get_children():
			if tile is Tile:
				tiles.append(tile)

func _on_should_color_tiles(tile_set_1: Global.Colors, tile_set_2: Global.Colors, tile_set_3: Global.Colors, tile_set_4: Global.Colors) -> void:
	for tile in tiles:
		if (tile.index >= 100 and tile.index <= 199) or tile.index == 0:
			tile.set_color(tile_set_1)
		if (tile.index >= 200 and tile.index <= 299) or tile.index == 12:
			tile.set_color(tile_set_2)
		if (tile.index >= 300 and tile.index <= 399) or tile.index == 24:
			tile.set_color(tile_set_3)
		if (tile.index >= 400 and tile.index <= 499) or tile.index == 36:
			tile.set_color(tile_set_4)
