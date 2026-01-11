class_name Tile extends TextureButton

@onready var color_rect: ColorRect = $ColorRect

@export var type: Global.Colors = Global.Colors.NONE
@export var index: int

func _ready() -> void:
	self_modulate = Global.get_rgb_from_color(type)

func _on_pressed() -> void:
	Global.tile_pressed.emit(index)
