extends CharacterBody2D
@export var speed = 800
var AI: Node2D = null
var knocked = false
var strength = 5
var d_name = "Player"

func _ready():
	add_to_group("player")

func get_input():
	look_at(get_global_mouse_position())
	$Sprite2D.global_rotation = 0.0
	velocity = transform.x * Input.get_axis("down", "up") * speed
	#var input_direction = Input.get_vector("left", "right", "up", "down")
	$hitarea.look_at(get_global_mouse_position())
	#velocity = input_direction * speed

func _physics_process(delta):
	
	if knocked:

		move_and_slide()
	else:
		get_input()
		move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		print(AI)
	if (AI != null and Input.is_action_just_pressed("click")):
		var area = $hitarea/hitbox.global_position
		var direction = (area - global_position) * 5
		AI.apply_knockback(direction, 25)
		var s = get_tree().get_nodes_in_group("player")
		s[0].apply_knockback(-1 * direction, 25)
		print("Global_Pos:",global_position )
		print("area:", $hitarea/hitbox.global_position )
		print("direction:", direction)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai'):
		AI = body


func _on_hitarea_body_exited(body: Node2D) -> void:
	AI = null


#getting knocked back

func apply_knockback(direction: Vector2, strength: int):
	strength = strength
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
