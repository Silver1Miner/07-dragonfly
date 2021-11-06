extends Area2D
class_name Explosion

export var damage = 0
export var size_scale = 2
var lifetime = 0.5

func _ready() -> void:
	add_to_group("environmental")
	scale = Vector2(size_scale, size_scale)
	$Timer.wait_time = lifetime
	$Timer.start()
	$AnimatedSprite.play("default")

func _process(delta: float) -> void:
	position -= Vector2(PlayerData.SCROLL_SPEED, 0) * delta

func _on_Timer_timeout() -> void:
	queue_free()
