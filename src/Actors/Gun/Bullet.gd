extends Area2D
class_name Bullet

export var direction := Vector2.ZERO
export var speed := 100
export var lifetime := 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = lifetime
	$Timer.start()


func _process(delta: float) -> void:
	position += (delta * speed) * direction.normalized()


func _on_Timer_timeout() -> void:
	queue_free()
