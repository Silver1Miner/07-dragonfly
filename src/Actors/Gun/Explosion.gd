extends Area2D
class_name Explosion

export var damage = 0
export var size_scale = 1
var lifetime = 0.5

func _ready() -> void:
	add_to_group("environmental")
	scale = Vector2(size_scale, size_scale)
	$Timer.wait_time = lifetime
	$Timer.start()
	$AnimatedSprite.play("default")
	AudioManager.play_sound("res://assets/Audio/Splode.wav")

func _process(_delta: float) -> void:
	#position -= Vector2(PlayerData.SCROLL_SPEED, 0) * delta
	pass

func _on_Timer_timeout() -> void:
	queue_free()

func _on_Explosion_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.get_parent().take_damage(damage/2)
	elif area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(damage)
