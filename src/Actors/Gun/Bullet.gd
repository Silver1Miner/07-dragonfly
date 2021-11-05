extends Area2D
class_name Bullet

export var damage = 5
export var direction := Vector2.ZERO
export var speed := 100
export var lifetime := 1
var target_groups = ["enemy"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = lifetime
	$Timer.start()


func _process(delta: float) -> void:
	position += (delta * speed) * direction.normalized()


func _on_Timer_timeout() -> void:
	queue_free()


func _on_Bullet_area_entered(area: Area2D) -> void:
	for group in target_groups:
		if area.is_in_group(group):
			queue_free()
