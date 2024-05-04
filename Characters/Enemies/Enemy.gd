extends Character
# Класс + картинка
class_name Enemy, "res://Assets/enemies/enemies_prev.png"


# Переменные
# Переменная пути
var path: PoolVector2Array
# Навигация
onready var navigation: Navigation2D = get_tree().current_scene.get_node("Rooms")
# Получаем игрока
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")

onready var max_hp = hp
onready var animation_health_bar: AnimationPlayer = get_node("HealthBar/AnimationPlayer")

onready var health_bar: TextureProgress = get_node("HealthBar")
onready var health_bar_tween: Tween = get_node("HealthBar/Tween")

onready var path_timer: Timer = get_node("PathTimer")

var isReady = false


func _ready() -> void:
	_update_health_bar(100)
	isReady = true

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

func _die_handler(hp: int) -> void:
	if hp > 0: return
	_on_die()

func _update_health_bar(new_value: int) -> void:
	var __ = health_bar_tween.interpolate_property(
		health_bar, 
		"value",
		health_bar.value, 
		new_value, 
		0.5, 
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	__ = health_bar_tween.start()

func _on_hp_changed(new_hp: int) -> void:
	if !isReady: return
	var new_health = int(100 * new_hp / max_hp)
	_update_health_bar(new_health)
	_die_handler(new_health)

func _on_die() -> void:
	animation_health_bar.play("Hide")

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


