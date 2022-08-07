extends Node2D


# Переменные
# Константа сцены появления мобов
const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Characters/Enemies/SpawnExplosion.tscn")
# Коллекция мобов в константе
const ENEMY_SCENES: Dictionary = {
	"FLYING_CREATURE": preload("res://Characters/Enemies/Flying Creature/FlyingCreature.tscn"),
}
# Количество мобов
var num_enemies: int
# Переменные объектов на карте
onready var tilemap: TileMap = get_node("BorderTileMap")
onready var entrance: Node2D = get_node("Entrance")
onready var door_container: Node2D = get_node("Doors")
onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
onready var player_detector: Area2D = get_node("PlayerDetector")


# Функции
func _ready() -> void:
	num_enemies = enemy_positions_container.get_child_count()


# Когда все враги убиты
func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()


# Функция открытия дверей
func _open_doors() -> void:
	for door in door_container.get_children():
		door.open()


# Функция закрытие дверей при входе в комнату
func _close_entrance() -> void:
	for entry_position in entrance.get_children():
		# Цифры в конце после запятой, это номер тайл сета, на тайл сет навестить и там название
		# фулл_спрайтшит.пнг 2
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position), 2)
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position) + Vector2.DOWN, 3)


# Функция спавна мобов
func _spawn_enemies() -> void:
	for enemy_position in enemy_positions_container.get_children():
		var enemy: KinematicBody2D = ENEMY_SCENES.FLYING_CREATURE.instance()
		var __ = enemy.connect("tree_exited", self, "_on_enemy_killed")
		enemy.position = enemy_position.position
		call_deferred("add_child", enemy)
		# Спавним под мобом взрыв, при его спавне
		var spawn_explosion: AnimatedSprite = SPAWN_EXPLOSION_SCENE.instance()
		spawn_explosion.position = enemy_position.position
		call_deferred("add_child", spawn_explosion)


# При входе в комнату
func _on_PlayerDetector_body_entered(_body: KinematicBody2D) -> void:
	player_detector.queue_free()
	if num_enemies > 0:
		_close_entrance()
		_spawn_enemies()
	else:
		_open_doors()









