extends Node

const player_colors: Array[StringName] = ["green", "blue", "red", "yellow", "orange", "purple"]

var player_color_tiles: Dictionary = {
	"blue": load("res://Assets/Game/blue_tile.png"), 
	"green": load("res://Assets/Game/green_tile.png"),
	"orange": load("res://Assets/Game/orange_tile.png"),
	"purple": load("res://Assets/Game/purple_tile.png"),
	"red": load("res://Assets/Game/red_tile.png"),
	"yellow": load("res://Assets/Game/yellow_tile.png"),
}

enum GAME_TYPE {
	SINGLEPLAYER,
	LOCAL_MULTIPLAYER,
	ONLINE_MULTIPLAYER
}

enum PLAYER_COLORS {
	YELLOW,
	RED,
	BLUE,
	GREEN,
	ORANGE,
	PURPLE,
}

var main_scene: Main
