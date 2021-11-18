extends Enemy

export var cooldown = 4.0
export var bomb_speed = 300
var bomb_velocity = Vector2.LEFT

func _ready() -> void:
	$Gun.disabled = true
	$Bomber.cooldown = cooldown
	$Bomber.damage = 40

func _physics_process(_delta):
	if activated and entered_screen:
		bomb_velocity = (PlayerData.current_position - global_position).normalized() * bomb_speed
		$Bomber.bomb()
