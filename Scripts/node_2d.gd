extends CharacterBody2D

@export var speed = 800
@export var attack_range: float = 40.0
@export var attack_cooldown: float = 0.3
var can_attack = true
var is_attacking = false

func get_input():
	# Spieler dreht sich zur Maus
	look_at(get_global_mouse_position())

	# Bewegung entlang der lokalen X-Achse (WS)
	velocity = transform.x * Input.get_axis("down", "up") * speed

func _physics_process(delta):
	get_input()
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("click") and can_attack:
		perform_attack()

func perform_attack():
	can_attack = false

	var direction = (get_global_mouse_position() - global_position).normalized()
	
	# Hitbox erzeugen
	var hitbox := HitBox.new()
	hitbox.name = "PlayerHitbox"

	# Layer/Mask:
	# Layer 2 = PlayerAttack
	# Mask 1 = Gegner
	hitbox.collision_layer = 1
	hitbox.collision_mask = 0

	# Kollisionsform
	var shape := CollisionShape2D.new()
	shape.shape = CircleShape2D.new()
	shape.shape.radius = 20
	hitbox.add_child(shape)

	# Position der Hitbox vor dem Spieler
	hitbox.global_position = global_position + direction * attack_range
	# Hitbox in die Szene setzen
	get_parent().add_child(hitbox)

	# Hitbox kurz bestehen lassen (damit Gegner sie erkennen)
	await get_tree().create_timer(0.1).timeout
	hitbox.queue_free()

	# Cooldown
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
