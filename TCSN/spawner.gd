extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_count: int = 4
@export var spawn_radius: float = 100


func _ready():
	spawn_enemies()


func spawn_enemies():
	for i in range(spawn_count):
		var ai = enemy_scene.instantiate()

		# zufällige Position um den Spawner herum
		var angle = randf() * TAU
		var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
		ai.global_position = abs(global_position + offset)
		get_parent().add_child(ai)
