extends Node2D

var flip: bool = true

func _ready() -> void:
	set_process_input(true)


func _input(event: InputEvent) -> void:
	var distance = get_global_mouse_position() - self.global_position
	distance = Vector2(abs(distance.x), abs(distance.y))
	if event.is_action_pressed("turn_up"):
		if distance.x <= Status.card_size.x / 2 and distance.y <= Status.card_size.y / 2:
			_turn_up()


func _turn_up():
	if flip:
		$AnimationPlayer.play("flip_up");
		$Timer.start()
		flip = false


func _turn_down():
	if not flip:
		$AnimationPlayer.play("flip_down");
		flip = true


func _on_Timer_timeout() -> void:
	_turn_down()
