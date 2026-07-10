class_name Game extends Control

var actors: Array[Actor] = []

func _ready() -> void:
	Global.tile_pressed.connect(_on_tile_pressed)
	for child in $Actors.get_children():
		if child is Actor:
			actors.append(child)
			for actor_child in child.get_children():
				if actor_child is Pawn:
					actor_child.pressed.connect(_on_pawn_pressed)
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
	
	Global.should_color_tiles.emit(actors[0].color, actors[1].color, actors[2].color, actors[3].color)
	Global.dice_rolled.connect(_on_dice_rolled)

func _on_tile_pressed(tile_index: int) -> void:
	pass

func _on_dice_rolled(number: int) -> void:
	var actor: Actor = TurnManager.get_turn()
	for pawn in actor.pawns:
		if not pawn.in_spawn or number == 6:
			pawn.set_selection_blink(true)
			await pawn.pressed
			print("gowno")
	
	#if actor.pawns[pawn_index].path_index + number >= 51:
	#	actor.pawns[pawn_index].path_index = 51
	#	Global.game_won.emit(actor)
	#	print('wygrał: ', actor)
	#	return
	
	#actor.pawns[pawn_index].path_index += number
	#if number == 6:
	#	actor.pawns[pawn_index].activate_ability()
	#else:
	#	TurnManager.set_next_turn()

func _on_pawn_pressed(pawn: Pawn) -> void:
	pass

func _physics_process(_delta: float) -> void:
	for actor in actors:
		for pawn in actor.pawns:
			var tile_position: Vector2 = _get_tile_position(actor.pawn_path[pawn.path_index])
			pawn.move(tile_position)

func _get_tile_position(tile_index: int) -> Vector2:
	for marker in $TileMarkers.get_children():
		if marker.index == tile_index:
			return marker.position
	return Vector2(0, 0)
