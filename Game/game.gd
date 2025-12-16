extends Control

@onready var board: Board = $"Board-4"
@onready var actors: Array[Actor]

func _ready() -> void:
	for child in $Players.get_children():
		if child is Actor:
			actors.append(child)
	
	TurnManager.turns = actors
	
	for tile in board.tiles:
		for actor in actors:
			if actor is Player:
				tile.tile_pressed.connect(actor._on_tile_pressed)
