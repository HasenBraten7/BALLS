extends Node2D

@export var ai_scene: PackedScene
@export var spawn_area := Rect2(Vector2.ZERO, Vector2(600, 400))
@export var min_distance := 50.0
@export var amount := 4

var spawned_positions: Array[Vector2] = []

func _ready() -> void:
	spawn_ai_group()


func spawn_ai_group() -> void:
	for i in range(amount):
		var pos = get_valid_spawn_position()
		if pos == null:
			push_warning("Keine gültige Spawn-Position gefunden")
			continue

		var ai = ai_scene.instantiate()
		ai.position = pos
		add_child(ai)
		spawned_positions.append(pos)


func get_valid_spawn_position() -> Vector2:
	var max_attempts := 30

	for attempt in range(max_attempts):
		var candidate = Vector2(
			abs(randf_range(spawn_area.position.x, spawn_area.end.x)),
			abs(randf_range(spawn_area.position.y, spawn_area.end.y))
		)

		if is_position_valid(candidate):
			return candidate

	return Vector2(100.0,100.0)


func is_position_valid(pos: Vector2) -> bool:
	for existing in spawned_positions:
		if pos.distance_to(existing) < min_distance:
			return false
	return true
