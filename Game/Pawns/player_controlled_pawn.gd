class_name PlayerControlledPawn extends Pawn

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	if sprite != null:
		sprite.texture = pawn_texture
