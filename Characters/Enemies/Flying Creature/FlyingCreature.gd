extends Enemy


# Переменные
onready var hitbox: Area2D = get_node("Hitbox")


# Функции

func _process(_delta: float) -> void:
	hitbox.knockback_direction = velocity.normalized()
