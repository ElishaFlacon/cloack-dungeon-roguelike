extends CanvasLayer


# Переменные
# Минимальное хп для отображения на хелф баре
# Хелф бар и там ползунок валуе, если больше сделать, красная полоска вылезет
# А делать меньше нет смысла
const MIN_HEALTH: int = 23
# Максимальное хп
var max_hp: int = 4
# Получаем игрока
onready var player: KinematicBody2D = get_parent().get_node("Player")
# Получаем хп бар
onready var health_bar: TextureProgress = get_node("HealthBar")
# Получаем твин в хп баре
onready var health_bar_tween: Tween = get_node("HealthBar/Tween")


# Функции
# Готова?!
func _ready() -> void:
	max_hp = player.hp
	_update_health_bar(100)

# Функция обновления хп бара
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


# Принимаем сигнал смены хп
func _on_Player_hp_changed(new_hp: int) -> void:
	# Меняем хп
	var new_health: int = int((100 - MIN_HEALTH) * float(new_hp) / max_hp) + MIN_HEALTH
	_update_health_bar(new_health)



