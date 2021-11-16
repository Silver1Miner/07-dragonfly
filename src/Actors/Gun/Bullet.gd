extends Area2D
class_name Bullet

export var damage :float = 5
export var direction :Vector2 = Vector2.ZERO
export var speed :float = 100
export var lifetime :float = 1.0
export var piercing :bool = false
var target_groups :Array = ["enemy"]
export var Explosion: PackedScene

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
		if area.is_in_group(group) and area.get_parent().has_method("take_damage"):
			area.get_parent().take_damage(damage)
			if !piercing:
				var explosion: Explosion = Explosion.instance()
				explosion.damage = 0
				explosion.size_scale = 1
				explosion.global_position = global_position
				ObjectRegistry.register_bullet(explosion)
				queue_free()
