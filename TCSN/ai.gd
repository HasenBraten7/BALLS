extends CharacterBody2D

@export var speed := 800
@export var knockback = 100
@export var recoil = 10
@export var knockback_resistance: float = 1
var knockback_n = Vector2.ZERO

var knockback_velocity: Vector2 = Vector2.ZERO
var knockback_decay := 80.0
var is_knocked_back := false
var current_target: CharacterBody2D = null

func _ready():
	add_to_group("characters")

	var timer := Timer.new()
	timer.wait_time = randi_range(1, 3)
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_retarget_timeout)
	add_child(timer)

	_on_retarget_timeout()

	# WICHTIG: Gegner reagiert auf Hitboxen
	#connect("area_entered", Callable(self, "_on_area_entered"))


func _on_retarget_timeout():
	current_target = get_random_entity()


func get_random_entity() -> CharacterBody2D:
	var chars = get_tree().get_nodes_in_group("characters")

	if chars.size() <= 1:
		return null

	chars.erase(self)
	randomize()
	return chars[randi() % chars.size()]


func move_towards_target(target: CharacterBody2D):
	if target == null:
		velocity = Vector2.ZERO
		return

	var direction = (target.global_position - global_position).normalized()
	velocity = direction * speed


func _physics_process(delta):
	if is_knocked_back:
		move_and_slide()
		knockback = knockback.move_toward(Vector2.ZERO, knockback_resistance)
		velocity += knockback * delta
		global_position += velocity
	else:
		# Normale Bewegung
		move_towards_target(current_target)
	move_and_slide()


func take_damage(knockback_strength: int, from_position: Vector2, hitbox: HitBox):
	is_knocked_back = true
	self.knockback = hitbox.global_position.direction_to(self.global_position)
	print("hit.glo:", hitbox.global_position)
	print("self-global:", self.global_position)
	print("knockback",knockback)
