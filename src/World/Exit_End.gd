extends Area2D

export var wait_time := 120
var active = false

func _ready() -> void:
	$Timer.wait_time = wait_time
	$Timer.start()

func _process(delta: float) -> void:
	if active:
		position.x -= 50 * delta

func _on_Timer_timeout() -> void:
	active = true
