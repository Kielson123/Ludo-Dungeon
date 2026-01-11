class_name Game extends Control

var dice_roller: Actor = null
var actors: Array[Actor] = []

func _ready() -> void:
	Global.tile_pressed.connect(_on_tile_pressed)
	for child in $Actors.get_children():
		if child is Actor:
			actors.append(child)
			for actor_child in child.get_children():
				if actor_child is Pawn:
					child.pawns.append(actor_child)
	TurnManager.turns = actors
	
	var start_index: int = 0
	var home_index: int = 100
	for actor in actors:
		for i in range(48):
			actor.pawn_path.append((i + start_index) % 48)
		for i in range(4):
			actor.pawn_path.append(i + home_index)
		start_index += 12
		home_index += 100

func _on_tile_pressed(tile_index: int) -> void:
	#var tile_position: Vector2 = get_tile_position(tile_index)
	#pawn.position = tile_position
	pass

func get_tile_position(tile_index: int) -> Vector2:
	for marker in $TileMarkers.get_children():
		if marker.index == tile_index:
			return marker.position
	return Vector2(0, 0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_down"):
		pass
