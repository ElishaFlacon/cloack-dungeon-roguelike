extends StaticBody2D


# Переменные
# Получаем анимации двери
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")


# Функции
# Функция открытия двери
func open() -> void:
	animation_player.play("open")
