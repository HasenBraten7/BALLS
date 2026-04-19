extends CharacterBody2D
@export var speed = 400
var AI: Node2D = null
var knocked = false
var strength = 20



func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	$hitarea.look_at(get_global_mouse_position())
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	if knocked:
		#print()
		move_and_slide()
	else:
		#searching einfügen
		move_and_slide()

func _process(delta: float) -> void:
	if (AI != null and Input.is_action_just_pressed("click")):
		print("Test")
		var area = $hitarea.global_position
		var direction = (area - global_position)
		AI.apply_knockback(direction)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Test2")
	if(body.name == 'Ai'):
		AI = body


func _on_hitarea_body_exited(body: Node2D) -> void:
	AI = null


#getting knocked back

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
	print("hello")

func _knocked_end():
	print("End")
	knocked = false
	velocity = Vector2.ZERO
