extends Navigation2D


# Переменные и константы
# Комнаты спавна
const SPAWN_ROOMS: Array = [preload("res://Rooms/Room0.tscn")]
# Промежуточные комнаты
const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/SpawnRoom0.tscn"), preload("res://Rooms/SpawnRoom1.tscn")]
# Последние комнаты
const END_ROOMS: Array = [preload("res://Rooms/EndRoom0.tscn")]
