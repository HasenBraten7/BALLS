extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_count: int = 4
@export var spawn_radius: float = 500


func _ready():
	var enemies = [enemy_scene.instantiate(),enemy_scene.instantiate(),enemy_scene.instantiate(),enemy_scene.instantiate()]
	spawn_enemies(enemies)


func spawn_enemies(enemies):
	for i in enemies:
		var ai = i
		var spawn_location
		var offset
		
		spawn_location = abs(Vector2(randf() * spawn_radius,randf()*spawn_radius))
		ai.global_position = spawn_location
		print(ai.global_position)
		add_child(ai)
