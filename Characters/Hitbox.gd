extends Area2D
# Класс 
class_name Hitbox


# Переменные
# Урон
export(int) var damage: int = 1
# Множитель критического урна
export(int) var multiplier_crit: int = 3
# Шанс крита, от 0 до 1
export(float) var crit_chance: float = 0.15
# Переменная рандома
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
# Направление отталкивания
var knockback_direction: Vector2 = Vector2.ZERO
# Сила отталкивания
export(int) var knockback_force: int = 300
# Получаем колизион шапе
onready var collision_shape: CollisionShape2D = get_child(0)


# Функции
# Функция инициализации анимаций
func _init() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")


# Готова?!
func _ready() -> void:
	assert(collision_shape != null)


# Функция округляет цифры, теперь не 0.199999 а 0.19
func round_to_dec(num: float, digit: int) -> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)


# Функция выщитывает критический урон
# randf_range генерирует с учетом псевдорандома
func critical_damage() -> int:
	rng.randomize()
	var trying = rng.randf_range(0.0, 1.0)
	trying = round_to_dec(trying, 2)
	if crit_chance >= trying:
		return damage * multiplier_crit
	else:
		return damage


# Функция удара, получения урона при входе в хитбокс меча
func _on_body_entered(body: PhysicsBody2D) -> void:
	body.take_damage(critical_damage(), knockback_direction, knockback_force)
	body.set_hp(body.hp) 
