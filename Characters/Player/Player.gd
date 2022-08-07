extends Character


# Переменные
# Получаем меч
onready var sword: Node2D = get_node("Sword")
# Получаем хитбокс меча
onready var sword_hitbox: Area2D = get_node("Sword/Node2D/Sprite/Hitbox")
# Получаем анимацию меча
onready var sword_animation_player: AnimationPlayer = sword.get_node("SwordAnimationPlayer")


# Функции
# Функция процесс, внутри описывыется поведение спрайта игрока при движении мыши
# А так же поведение меча
func _process(_delta: float) -> void:
	# Переменная в который записана позиция мыши
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	# Прописываем логику движения игрока относительно позиции мыши
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
	# Прописываем поведение меча
	sword.rotation = mouse_direction.angle()
	sword_hitbox.knockback_direction = mouse_direction
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.y = 1


# В этой функции прописываем логику движений игрока при нажатии на кнопки
func get_input() -> void:
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		mov_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		mov_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		mov_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		mov_direction += Vector2.UP
	if Input.is_action_just_pressed("ui_attack") and not sword_animation_player.is_playing():
		sword_animation_player.play("attack")


# В этой функции прописываем логику камеры
func switch_camera() -> void:
	var main_sceen_camera: Camera2D = get_parent().get_node("Camera2D")
	main_sceen_camera.position = position
	main_sceen_camera.current = true
	get_node("Camera2D").current = false
