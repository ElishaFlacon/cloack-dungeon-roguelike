extends AnimatedSprite


# Функции
# Готова?!
func _ready() -> void:
	playing = true


# Функция пропадания эффекта
func _on_SpawnExplosion_animation_finished() -> void:
	queue_free()
