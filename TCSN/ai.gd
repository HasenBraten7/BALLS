extends CharacterBody2D

@export var speed := 400
@export var knockback = 100 #Knockback des gegners
@export var recoil = 10 #eigener knockback

var current_target: CharacterBody2D = null

func _ready():
	add_to_group("characters")

	# Timer that picks a new target every few seconds
	var timer := Timer.new()
	timer.wait_time = randi_range(0, 3)
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_retarget_timeout)
	add_child(timer)

	# Pick an initial target
	_on_retarget_timeout()


func _on_retarget_timeout():
	current_target = get_random_entity()


func get_random_entity() -> CharacterBody2D:
	var chars = get_tree().get_nodes_in_group("characters")

	if chars.size() <= 1:
		return null #nur noch eine AI am überleben

	# Remove self from the list
	chars.erase(self)

	# zufalls ziel
	randomize()
	return chars[randi() % chars.size()]


func move_towards_target(target: CharacterBody2D):
	if target == null:
		velocity = Vector2.ZERO
		return

	var direction = (target.global_position - global_position).normalized()
	velocity = direction * speed


func _physics_process(delta):
	move_towards_target(current_target)
	move_and_slide()
