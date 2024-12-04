class_name Board4 extends Board

var player_data: Array[Dictionary] = [{}, {}, {}, {}]

func _ready() -> void:
	for i in starting_tiles.size():
		starting_tiles[i].texture = Global.player_color_tiles[player_data[i]["color"]]
