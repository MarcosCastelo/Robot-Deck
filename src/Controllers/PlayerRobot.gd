extends KinematicBody2D

const GRAVITY = 800;
const JUMP = -1000;
const sprite_scale = 0.2

var can_move = true
var stopped = true

var health = 100
var strength = 1
var speed = 400


var velocity = Vector2()

func _ready() -> void:
	set_process(true)
	set_physics_process(true)
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_attack"):
		can_move = false
		stopped = false
		attack()

func _physics_process(delta: float) -> void:
	if can_move:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -speed
			$AnimatedSprite.scale.x = -sprite_scale
		elif Input.is_action_pressed("ui_right"):
			velocity.x = speed
			$AnimatedSprite.scale.x = sprite_scale
		else:
			velocity.x = 0;
		
		if velocity.x != 0:
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("idle")
		
		move_and_slide(velocity, Vector2(0, -1))
		velocity.y = GRAVITY
	if Input.is_action_pressed("defense") and stopped:
		can_move = false
		$AnimatedSprite.play("idle")
		$AnimatedSprite/Shield.visible = true
	elif Input.is_action_just_released("defense"):
		$AnimatedSprite/Shield.visible = false
		can_move = true

func _process(delta: float) -> void:
	if health >= 0:
		$LifeBar.scale.x *= 100/100

func attack():
	$AnimatedSprite.speed_scale = 1
	$AnimatedSprite/AttackArea.visible = true
	$AnimatedSprite.play("attack")
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.speed_scale = 1
	$AnimatedSprite/AttackArea.visible = false
	stopped = true
	can_move = true


func getDamage(damage):
	health -= damage

func setHealth(health):
	self.health += health

func setSpeed(speed):
	self.speed += speed

func setStrength(strength):
	self.strength += strength
