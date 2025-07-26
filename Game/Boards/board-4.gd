@icon("res://Assets/Node Icons/board.png")
class_name Board extends Control

var tiles: Array[Tile] = []
var blanks: Array[Panel] = []

func _ready() -> void:
	get_all_tiles()

func _on_tile_pressed(tile: Tile, type: Tile.Type) -> void:
	pass

func get_all_tiles() -> void:
	for child in get_children():
		if child is MarginContainer and child.get_child(0) is VBoxContainer:
			for row in child.get_child(0).get_children():
				for square in row.get_children():
					if square is Tile:
						tiles.append(square)
						continue
					if square is Panel:
						blanks.append(square)

func get_tile_from_marker(marker: Marker2D) -> Tile:
	for tile in tiles:
		if tile.marker == marker:
			return tile
	printerr("Tile not found from marker: ", marker)
	return null
