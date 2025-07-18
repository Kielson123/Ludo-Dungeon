class_name Main extends Node

@export var dev_mode: bool = true
var _intro_finished: bool = false

func _on_intro_finished() -> void:
	_intro_finished = true
	$IntroContainer.queue_free()

func _ready() -> void:
	if dev_mode:
		$IntroContainer/AspectRatioContainer/Intro.finished.emit()
