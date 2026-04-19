extends CharacterBody2D


const SPEED = 500.0
var knocked = false
var AI: Node2D = null
var d_name = "Ai"
var states = ["IDLE", "HUNT_AI", "HUNT_PLAYER"]
var state = "IDLE"
var direction: Vector2
var strength: int = 2
var can_attack = true
var cooldown = 0.2
@export var animation_sprite: AnimatedSprite2D
@export var anim: AnimationPlayer

func _ready():
	add_to_group("AI")
	choose_state()
	
func _physics_process(delta: float) -> void:
	$AnimationPlayer.play("wackeln")
	$AnimatedSprite2D.play("default")
	if knocked:
		move_and_slide()
		print("Test Knock")
	else:
		if(state == "IDLE"):
			idle()
		elif state == "HUNT_PLAYER":
			direction = (get_Player_pos() - global_position)
			var dist = global_position.distance_to(get_Player_pos())
			if dist <= 20:
				idle()
			$hitarea.look_at(get_Player_pos())
		elif state == "HUNT_AI":
			direction = (get_closest_AI() - global_position)
			var dist = global_position.distance_to(get_closest_AI())
			if dist <= 20:
				idle()
			$hitarea.look_at(get_closest_AI())
		velocity = direction.normalized() * SPEED
		move_and_slide()
	

func apply_knockback(direction: Vector2, strength: int):
	strength = strength
	print("Knocked")
	knocked = true
	velocity = direction * strength
	var timer := Timer.new()
	timer.wait_time = 0.1
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(_knocked_end)
	add_child(timer)
	timer.start()
	print(strength)

func _knocked_end():
	knocked = false
	velocity = Vector2.ZERO


func _on_hitarea_body_entered(body: Node2D) -> void:
	if(body.name != "TileMapLayer"):
		if can_attack:
			print("Body:", body.name)
			if(body.d_name == "Ai" or body.d_name == "Player"):
				AI = body
			if (AI != null):
				print("HIT!")
				can_attack = false
				var area = $hitarea.global_position
				var direction = (area - global_position)  * 5
				var timer := Timer.new()
				timer.wait_time = cooldown
				timer.autostart = false
				timer.one_shot = true
				timer.timeout.connect(set_can_attack)
				add_child(timer)
				timer.start()
				AI.apply_knockback(direction, 5)
				self.apply_knockback(-1 * direction, 5)

func set_can_attack():
	can_attack = true

func _on_hitarea_body_exited(body: Node2D) -> void:
	AI = null

func choose_state():
	randomize()
	var timer := Timer.new()
	timer.wait_time = (randi() % 4 ) +1
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(choose_state)
	add_child(timer)
	timer.start()
	if randi() % 50 < 25:
		state = "HUNT_PLAYER"
	else:
		state = states[randi() % 2]

func get_closest_AI() -> Vector2:
	var actors = get_tree().get_nodes_in_group("AI")
	var closest = null
	var closest_dist = INF

	for actor in actors:
		if actor == self:
			continue

		var dist = global_position.distance_to(actor.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest = actor
	if closest == null:
		states[2] ="HUNT_PLAYER"
		return global_position
	else:
		return (closest.global_position * 1)
		
func get_Player_pos() -> Vector2:
	var actor = get_tree().get_nodes_in_group("player")
	var pos = actor[0].global_position
	return (pos * 1.0)

func idle():
	velocity = Vector2.ZERO
