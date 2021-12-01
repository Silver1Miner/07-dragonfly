extends KinematicBody2D

func _ready() -> void:
	$Label.visible = PlayerData.tutorial
	$Label2.visible = PlayerData.tutorial
	$Label3.visible = PlayerData.tutorial
	$Sprite2.visible = !PlayerData.tutorial

func _process(delta: float) -> void:
	position.y = position.y
	position.x -= 40 * delta
