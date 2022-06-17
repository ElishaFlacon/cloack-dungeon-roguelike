extends Character
# Класс + картинка
class_name Enemy, "res://Assets/enemies/enemies_prev.png"


# Переменные
# Переменная пути
var path: PoolVector2Array
# Навигация
onready var navigation: Navigation2D = get_tree().current_scene.get_node("Navigation2D")
# Получаем игрока
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var path_timer: Timer = get_node("PathTimer")


# Функции
# Функция со всей логикой передвижения энеми
func chase() -> void:
	# Прописываем логику движения энеми
	if path:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		if distance_to_next_point < 1:
			path.remove(0)
			if not path:
				return
		# Прописываем логику поворота спрайта
		mov_direction = vector_to_next_point
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true


# Логика связанная с таймером
# Типо когда таймер обновляется, то
# Енеми ищет ближайший путь до игрока
func _on_PathTimer_timeout() -> void:
	if is_instance_valid(player):
		path = navigation.get_simple_path(global_position, player.position)
	else:
		path_timer.stop()
		path = []
		mov_direction = Vector2.ZERO
