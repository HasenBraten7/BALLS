extends CharacterBody2D

@export var speed = 400

func _ready():
	add_to_group("characters")  # sorgt dafür, dass dieser Node gefunden wird

func get_nearest_entity() -> CharacterBody2D:
	var nearest: CharacterBody2D = null
	var furthest: CharacterBody2D = null
	var nearest_dist := INF
	var furthest_dist := INF

	var chars = get_tree().get_nodes_in_group("characters")

	for c in chars:
		if c == self:
			continue

		var dist = global_position.distance_to(c.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = c
		if dist > furthest_dist:
			furthest_dist = dist
			furthest = c
			
	if bool(randi() % 2):
		#print("Furthest")
		#dprint(furthest.global_position)
		return furthest
	else:
		#print("Nearest")
		return nearest


func move_towards_target(target: CharacterBody2D):
	if target == null:
		velocity = Vector2.ZERO
		return

	var direction = (target.global_position - global_position).normalized()
	velocity = direction * speed


func _physics_process(delta):
	var nearest = get_nearest_entity()
	move_towards_target(nearest)
	move_and_slide()
