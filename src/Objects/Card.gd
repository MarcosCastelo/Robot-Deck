extends Node2D

var flip: bool = true
var onHand: bool = false
var onSlot: bool = false
var onTable: bool = true
var _grabbing: bool = false
var initialPosition: Vector2 = Vector2.ZERO
var attachedParent: Object

func _ready() -> void:
	$AnimationPlayer.play("down")
	set_process_input(true)
	set_process(true)


func _process(delta: float) -> void:
	if _grabbing:
		_grab(get_global_mouse_position())


func _input(event: InputEvent) -> void:
	var distance = get_global_mouse_position() - self.global_position
	distance = Vector2(abs(distance.x), abs(distance.y))
	if event.is_action_pressed("turn_up"):
		if distance.x <= Status.card_size.x / 2 and distance.y <= Status.card_size.y / 2:
			_turn_up()
	if event.is_action_pressed("pick_up"):
		if distance.x <= Status.card_size.x / 2 and distance.y <= Status.card_size.y / 2 and not onHand:
			_pick_up()
	if event.is_action("grab"):
		if distance.x <= Status.card_size.x / 2 and distance.y <= Status.card_size.y / 2 and not onTable and not _grabbing:
			initialPosition = self.position
			_grabbing = true
	if event.is_action_released("grab"):
		_release(initialPosition)
		if onRobot(Game.robot.getSlots()):
			initialPosition = self.position
			onSlot = true

func _grab(position: Vector2):
	self.global_position = position
	
func _release(position: Vector2):
	_grabbing = false
	self.position = position

func _turn_up():
	if flip and not onHand:
		$AnimationPlayer.play("flip_up");
		$Timer.start()
		flip = false


func _turn_down():
	if not flip and not onHand:
		$AnimationPlayer.play("flip_down");
		flip = true

func _pick_up():
	if Game.attach_on_hand(self):
		onHand = true
		onTable = false
		$AnimationPlayer.play("on_hand")


func onRobot(robot):
	for slot in robot:
		var distance = slot['position'] - self.global_position
		distance = Vector2(abs(distance.x), abs(distance.y))
		if distance.x <= Status.card_size.x / 2 and distance.y <= Status.card_size.y / 2:
			return Game.attach_on_robot(self, slot['slot'])
	return false


func _on_Timer_timeout() -> void:
	_turn_down()
