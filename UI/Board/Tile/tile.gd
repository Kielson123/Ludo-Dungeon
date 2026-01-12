class_name Tile extends TextureButton

@onready var color_rect: ColorRect = $ColorRect

@export var color: Global.Colors = Global.Colors.NONE
@export var index: int

func _ready() -> void:
	self_modulate = Global.get_rgb_from_color(color)

func _on_pressed() -> void:
	Global.tile_pressed.emit(index)

func set_color(new_color: Global.Colors) -> void:
	color = new_color
	self_modulate = Global.get_rgb_from_color(new_color)
