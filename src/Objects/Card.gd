extends Node2D


func _ready() -> void:
	set_process(true)
	set_process_input(true)


func _input(event: InputEvent) -> void:
	var distance = get_global_mouse_position() - self.global_position
	distance = Vector2(abs(distance.x), abs(distance.y))
	if event.is_action_pressed("turn_up"):
		if distance.x <= Status.card_size.x / 2 and distance.y <= Status.card_size.y / 2:
			_turn_up()
	if event.is_action_pressed("turn_down"):
		if distance.x <= Status.card_size.x / 2 and distance.y <= Status.card_size.y / 2:
			_turn_down()


func _turn_up():
	return


func _turn_down():
	return
