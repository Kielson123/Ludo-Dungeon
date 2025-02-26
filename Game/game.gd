class_name Game extends Control

#region VARIABLES
const BOARD_4 = preload("res://Game/Boards/Board4/board_4.tscn")

var pawns: Array[Node]

var _pawn_index: int = 0
var _bot_delay: int

var game_ended: bool = false
#endregion

#region SETUP FUNCTIONS
func _ready() -> void:
	Global.request_game_start.connect(on_game_start)

func on_game_start(game_type: Global.GAME_TYPE, data: Dictionary) -> void:
	set_visible(true)
	match game_type:
		Global.GAME_TYPE.SINGLEPLAYER:
			setup_singleplayer(data)
		Global.GAME_TYPE.LOCAL_MULTIPLAYER:
			setup_local_multiplayer(data)
		Global.GAME_TYPE.ONLINE_MULTIPLAYER:
			setup_online_multiplayer(data)

func setup_singleplayer(game_data: Dictionary) -> void:
	var type: int = game_data["type"]
	var board: Board
	match type:
		4:
			board = BOARD_4.instantiate()
		_:
			printerr("Specified game type doesn't exist!")
	
	for i in range(type):
		var player_data: Dictionary = game_data["player" + str(i+1)]
		if player_data.has_all(["color", "is_bot"]):
			var actor: Control = Bot.new() if player_data["is_bot"] else Player.new()
			for j in range(4):
				var pawn: Pawn = BotPawn.new() if player_data["is_bot"] else PlayerPawn.new()
				pawn.color = player_data["color"]
				pawn.texture = Global.player_color_pawns[actor.color]
				pawn.game = self
				pawn.add_to_group("Pawns")
				actor.pawns.append(pawn)
				add_child(pawn)
			
	add_child(board)
	for pawn: Pawn in pawns:
		pawn.moved.connect(_on_pawn_moved)

func setup_local_multiplayer(_game_data: Dictionary) -> void:
	pass

func setup_online_multiplayer(_game_data: Dictionary) -> void:
	pass
#endregion

#region RUNTIME FUNCTIONS
func _process(_delta: float) -> void:
	manage_game_events()
	manage_turns()

func manage_game_events() -> void:
	if game_ended:
		get_tree().free()

func manage_turns() -> void:
	var pawn: Pawn = pawns[_pawn_index]
	
	if pawn.can_move and pawn.finished_moving :
		_pawn_index = (_pawn_index + 1) % pawns.size()
		pawn.can_move = false
		pawn.finished_moving = false
	elif pawn.can_move and not pawn.finished_moving:
		pass
	elif not pawn.can_move and pawn.finished_moving:
		pass
	elif not pawn.can_move and not pawn.finished_moving:
		if pawn is BotPawn: 
			if _bot_delay < 0:
				pawn.can_move = true
				_bot_delay = randi_range(45, 100)
			else:
				_bot_delay -= 1
		else:
			pawn.can_move = true

func _on_pawn_moved(pawn: Pawn, tile: TextureRect) -> void:
	for pawn1: Pawn in pawns:
		if tile == pawn1.standing_tile and not pawn1 == pawn:
			pawns.erase(pawn1)
			pawn1.queue_free()
			break
#endregion
