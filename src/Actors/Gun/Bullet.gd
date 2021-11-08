extends Area2D
class_name Bullet

export var damage :float = 5
export var direction :Vector2 = Vector2.ZERO
export var speed :float = 100
export var lifetime :float = 1.0
export var piercing :bool = false
var target_groups :Array = ["enemy"]

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
		if area.is_in_group(group) and !piercing:
			queue_free()
