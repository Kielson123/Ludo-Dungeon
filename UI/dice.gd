class_name Dice extends TextureButton

var _last_number_rolled: int = 1

func _ready() -> void:
	TurnManager.turn_changed.connect(_on_turn_changed)

func _get_texture(number: int) -> Texture2D:
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

func _roll_anim(number_rolled: int) -> void:
	var numbers: Array[int] = [1, 2, 3, 4, 5, 6]
	numbers.shuffle()
	var anim: Tween = get_tree().create_tween()
	anim.tween_method(set_texture_normal, _get_texture(_last_number_rolled), _get_texture(numbers[0]), 0.2)
	anim.tween_interval(0)
	anim.tween_method(set_texture_normal, _get_texture(numbers[0]), _get_texture(numbers[1]), 0.2)
	anim.tween_interval(0.01)
	anim.tween_method(set_texture_normal, _get_texture(numbers[1]), _get_texture(numbers[2]), 0.2)
	anim.tween_interval(0.01)
	anim.tween_method(set_texture_normal, _get_texture(numbers[2]), _get_texture(numbers[3]), 0.2)
	anim.tween_interval(0.02)
	anim.tween_method(set_texture_normal, _get_texture(numbers[3]), _get_texture(numbers[4]), 0.2)
	anim.tween_interval(0.03)
	anim.tween_method(set_texture_normal, _get_texture(numbers[4]), _get_texture(numbers[5]), 0.2)
	anim.tween_interval(0.05)
	var number5: int = numbers[5]
	numbers.erase(number_rolled)
	numbers.shuffle()
	anim.tween_method(set_texture_normal, _get_texture(number5), _get_texture(numbers[0]), 0.2)
	anim.tween_interval(0.08)
	anim.tween_method(set_texture_normal, _get_texture(numbers[0]), _get_texture(numbers[1]), 0.2)
	anim.tween_interval(0.13)
	anim.tween_method(set_texture_normal, _get_texture(numbers[1]), _get_texture(numbers[2]), 0.2)
	anim.tween_interval(0.21)
	anim.tween_method(set_texture_normal, _get_texture(numbers[2]), _get_texture(numbers[3]), 0.2)
	anim.tween_interval(0.34)
	anim.tween_method(set_texture_normal, _get_texture(numbers[3]), _get_texture(numbers[4]), 0.2)
	anim.tween_interval(0.55)
	anim.tween_method(set_texture_normal, _get_texture(numbers[4]), _get_texture(number_rolled), 0.2)

func _on_pressed() -> void:
	var number_rolled: int = randi_range(1, 6)
	disabled = true
	_roll_anim(number_rolled)
	await create_tween().tween_interval(5).finished
	_last_number_rolled = number_rolled
	Global.dice_rolled.emit(number_rolled)

func _on_turn_changed() -> void:
	disabled = false
