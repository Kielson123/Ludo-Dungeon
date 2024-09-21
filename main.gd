extends Node

@onready var background_color: ColorRect = $BackgroundColor

func _on_intro_finished() -> void:
	background_color.color = Color("4d4d4d")
	$AspectRatioContainer/Intro.queue_free()
