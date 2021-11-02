extends KinematicBody2D
class_name Player

const SPEED_FAST = 500
const SPEED_SLOW = 100
const SPEED_NORMAL = 300
var speed = 300 # pixels/second
var velocity = Vector2.ZERO

func _ready() -> void:
	pass

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_pressed("speed_slow"):
		speed = SPEED_SLOW
	elif Input.is_action_pressed("speed_fast"):
		speed = SPEED_FAST
	else:
		speed = SPEED_NORMAL
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
