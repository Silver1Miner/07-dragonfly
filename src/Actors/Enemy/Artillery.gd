extends Enemy

export var cooldown = 4.0
export var bomb_speed = 300
var bomb_velocity = Vector2.LEFT

func _ready() -> void:
	$Aim/Gun.disabled = true
	$Aim/Bomber.cooldown = cooldown
	$Aim/Bomber.damage = 40

func _physics_process(_delta):
	$Aim.look_at(PlayerData.current_position)
	if activated and entered_screen:
		bomb_velocity = (PlayerData.current_position - global_position).normalized() * bomb_speed
		$Aim/Bomber.bomb()
