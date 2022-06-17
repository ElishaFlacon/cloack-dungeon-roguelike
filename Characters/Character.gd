extends KinematicBody2D
# Класс + картинка
class_name Character, "res://Assets/heroes/heroes_prev.png"


# Переменные
# Сила трения?! Сопротивление?!
const FRICTION: float = 0.15
# Количество жизней
export(int) var hp: int = 2 setget set_hp
# Сигнал, для изменения жизней
signal hp_changed(new_hp)
# Ускорение
export(int) var accerelation: int = 40
# Максимальная скорость
export(int) var max_speed: int = 100
# Получаем стейт машин
onready var state_machine: Node = get_node("FiniteStateMachine")
# Получаем спрайт
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
# Мув директори, типо куда идем?!
var mov_direction: Vector2 = Vector2.ZERO
# Скорость игрока (пологаю)
var velocity: Vector2 = Vector2.ZERO


# Функции
# Физик процесс, внутри нее реализуется перемещение объекта
func _physics_process(_delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)


# Функция движения
func move() -> void:
	mov_direction = mov_direction.normalized()
	velocity += mov_direction * accerelation
	velocity = velocity.clamped(max_speed)


# Функция получения урона
func take_damage(dam: int, dir: Vector2, force: int) -> void:
	self.hp -= dam
	if hp > 0:
		state_machine.set_state(state_machine.states.hurt)
		velocity += dir * force
	else:
		state_machine.set_state(state_machine.states.dead)
		velocity += dir * force * 2


# Функция смены хп
func set_hp(new_hp: int) -> void:
	hp = new_hp
	emit_signal("hp_changed", new_hp)

























