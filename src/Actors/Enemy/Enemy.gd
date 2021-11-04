extends KinematicBody2D
class_name Enemy

export var speed := 50
export var direction := Vector2.DOWN

var max_hp = 20
var hp = 20

func _ready() -> void:
	pass

func _physics_process(delta):
	var velocity = speed * direction.normalized()
	var collision = move_and_collide(velocity * delta)
	if collision:
		direction.x = -direction.x
	if position.x < 120 + 16:
		direction.x = -direction.x
	elif position.x > 520 - 16:
		direction.x = -direction.x
	if position.y > 400 + 16:
		print("out of sight")
		queue_free()
