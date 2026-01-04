extends CenterContainer

@onready var v_box_container: VBoxContainer = $VBoxContainer

@export var tiles: Array[Tile] = []

func _ready() -> void:
	for h_box_container in v_box_container.get_children():
		for tile in h_box_container.get_children():
			if tile is Tile:
				tiles.append(tile)
