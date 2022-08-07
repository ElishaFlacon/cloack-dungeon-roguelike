extends Node
# Класс
class_name FiniteStateMachine


# Переменные
# Состояния
var states: Dictionary = {}
# Прошлое состояние
var previous_state: int = -1
# Состояние сейчас и присваеваем функцию к переменной
var state: int = -1 setget set_state
# Получаем родителя
onready var parent: Character = get_parent()
# Получаем анимации плеера
onready var animation_player: AnimationPlayer = parent.get_node("AnimationPlayer")


# Функции
# Физик процесс
func _physics_process(_delta: float) -> void:
	if state != -1:
		_state_logic(_delta)
		var transition: int = _get_transition()
		if transition != -1:
			set_state(transition)


# Функция логики состояния
func _state_logic(_delta: float) -> void:
	pass


# Функция перехода состояния
func _get_transition() -> int:
	return -1


#Функция добавления состояния
func _add_state(new_state: String) -> void:
	states[new_state] = states.size()


# Функция установки состояния
func set_state(new_state: int) -> void:
	_exit_state(state)
	previous_state = state
	state = new_state
	_enter_state(previous_state, state)


# Функция входа в состояние
func _enter_state(_previous_state: int, _new_state: int) -> void:
	pass


# Функция выхода в состояние
func _exit_state(_state_exited: int) -> void:
	pass
