class_name Dice extends TextureButton

func _ready() -> void:
	TurnManager.turn_changed.connect(_on_turn_changed)

func get_texture(number: int) -> Texture2D:
	match number:
		1:
			return load("res://Assets/UI/Dice/dice_1.svg")
		2:
			return load("res://Assets/UI/Dice/dice_2.svg")
		3:
			return load("res://Assets/UI/Dice/dice_3.svg")
		4:
			return load("res://Assets/UI/Dice/dice_4.svg")
		5:
			return load("res://Assets/UI/Dice/dice_5.svg")
		6:
			return load("res://Assets/UI/Dice/dice_6.svg")
		_:
			return load("res://Assets/UI/Dice/dice.svg")


func _on_pressed() -> void:
	var number_rolled: int = randi_range(1, 6)
	texture_normal = get_texture(number_rolled)
	disabled = true
	Global.dice_rolled.emit(number_rolled)

func _on_turn_changed() -> void:
	disabled = false
