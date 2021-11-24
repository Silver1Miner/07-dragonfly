extends KinematicBody2D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position.y = position.y
	position.x -= 40 * delta
