extends Navigation2D


# Переменные и константы
# Комнаты спавна
const SPAWN_ROOMS:  Array = [preload("res://Rooms/SpawnRoom0.tscn"), preload("res://Rooms/SpawnRoom1.tscn")]
# Промежуточные комнаты
const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/Room0.tscn"), preload("res://Rooms/Room1.tscn"), preload("res://Rooms/Room2.tscn")]
# Последние комнаты
const END_ROOMS: Array = [preload("res://Rooms/EndRoom0.tscn")]
# Размер тайлов
const TILE_SIZE: int = 16
# Индекс в тайл сете пола
const FLOOR_TILE_INDEX: int = 4
# Индекс в тайл сете правой стены
const RIGHT_WALL_TILE_INDEX: int = 6
# Индекс в тайл сете левой стены
const LEFT_WALL_TILE_INDEX: int = 5
# Количество уровней
export(int) var num_levels: int = 7
# Игрок
onready var player: KinematicBody2D = get_parent().get_node("Player")


# Функции
# Готова?!
func _ready() -> void:
	_spawn_rooms()


# Функция генерации комнат
func _spawn_rooms() -> void:
	var previous_room: Node2D
	for i in num_levels:
		var room: Node2D
		if i == 0:
			room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instance()
			player.position = room.get_node("PlayerSpawnPosition").position
		else:
			if i == num_levels - 1:
				room = END_ROOMS[randi() % END_ROOMS.size()].instance()
			else:
				room = INTERMEDIATE_ROOMS[randi() % INTERMEDIATE_ROOMS.size()].instance()
			var previous_room_tilemap: TileMap = previous_room.get_node("TileMap")
			var previous_room_door: StaticBody2D = previous_room.get_node("Doors/Door")
			var exit_tile_pos: Vector2 = previous_room_tilemap.world_to_map(previous_room_door.position)+ Vector2.UP * 2
			var corridor_height: int = randi() % 6 + 8
			for y in corridor_height:
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(-2, -y), LEFT_WALL_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(-1, -y), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(0, -y), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(1, -y), RIGHT_WALL_TILE_INDEX)
				
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(1, -int(corridor_height / 2)), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(1, -int(corridor_height / 2) -1), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(y, -int(corridor_height / 2)), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(y, -int(corridor_height / 2) - 1), FLOOR_TILE_INDEX)
				
			var room_tilemap: TileMap = room.get_node("TileMap")
			room.position = previous_room_door.global_position + Vector2.UP * room_tilemap.get_used_rect().size.y * TILE_SIZE + Vector2.UP * (1 + corridor_height) * TILE_SIZE + Vector2.LEFT * room_tilemap.world_to_map(room.get_node("Entrance/Position2D2").position).x * TILE_SIZE
		add_child(room)
		previous_room = room




















