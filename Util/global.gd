extends Node


signal request_main_menu()
signal request_options_menu()
signal request_singleplayer_start_menu()
signal request_game_start(game_type: Global.GAME_TYPE, data: Dictionary)


const player_colors: Array[StringName] = ["green", "blue", "red", "yellow", "orange", "purple"]


var player_color_tiles: Dictionary = {
	"blue": load("res://Assets/Game/Tiles/blue_tile.png"), 
	"green": load("res://Assets/Game/Tiles/green_tile.png"),
	"orange": load("res://Assets/Game/Tiles/orange_tile.png"),
	"purple": load("res://Assets/Game/Tiles/purple_tile.png"),
	"red": load("res://Assets/Game/Tiles/red_tile.png"),
	"yellow": load("res://Assets/Game/Tiles/yellow_tile.png"),
}
var player_color_pawns: Dictionary = {
	"blue": load("res://Assets/Game/Pawns/default_blue.svg"), 
	"green": load("res://Assets/Game/Pawns/default_green.svg"),
	"orange": load("res://Assets/Game/Pawns/default_orange.svg"),
	"purple": load("res://Assets/Game/Pawns/default_purple.svg"),
	"red": load("res://Assets/Game/Pawns/default_red.svg"),
	"yellow": load("res://Assets/Game/Pawns/default_yellow.svg"),
}
var main_scene: Main


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
