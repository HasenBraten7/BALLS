extends CharacterBody2D


const SPEED = 300.0
var knocked = false
var strength = 5
var AI: Node2D = null
var d_name = "Ai"
const states = ["IDLE", "HUNT_PLAYER", "HUNT_AI"]
var state = "IDLE"
var direction: Vector2


func _ready():
	add_to_group("AI")
	choose_state()
	
func _physics_process(delta: float) -> void:
	
	if knocked:
		#print()
		move_and_slide()
	else:
		if(state == "IDLE"):
			idle()
		elif state == "HUNT_PLAYER":
			direction = (get_Player_pos() - global_position)
			$hitarea.look_at(get_Player_pos())
		elif state == "HUNT_AI":
			direction = (get_closest_AI() - global_position)
			$hitarea.look_at(get_closest_AI())
		velocity = direction.normalized() * SPEED
		move_and_slide()
	

func apply_knockback(direction: Vector2):
	knocked = true
	velocity = direction * strength
	var timer := Timer.new()
	timer.wait_time = 0.1
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(_knocked_end)
	add_child(timer)
	timer.start()

func _knocked_end():
	knocked = false
	velocity = Vector2.ZERO


func _on_hitarea_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai' or body.d_name == "Player"):
		AI = body
	if (AI != null):
		var area = $hitarea.global_position
		var direction = (area - global_position)  * strength
		AI.apply_knockback(direction)


func _on_hitarea_body_exited(body: Node2D) -> void:
	AI = null

func choose_state():
	var timer := Timer.new()
	timer.wait_time = (randi() % 3 ) +1
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(choose_state)
	add_child(timer)
	timer.start()
	state = states[randi() % 3]

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

	return closest.global_position
	
func get_Player_pos() -> Vector2:
	var actor = get_tree().get_nodes_in_group("player")
	var pos = actor[0].global_position
	return pos

func idle():
	velocity = Vector2.ZERO
