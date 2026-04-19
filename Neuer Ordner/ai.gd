extends CharacterBody2D


const SPEED = 300.0
var knocked = false
var strength = 20
var AI: Node2D = null

func _physics_process(delta: float) -> void:
	if knocked:
		#print()
		move_and_slide()
	else:
		#searching einfügen
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
	print("hello")

func _knocked_end():
	print("End")
	knocked = false
	velocity = Vector2.ZERO


func _on_hitarea_body_entered(body: Node2D) -> void:
	print("Test2")
	if(body.name == 'Ai' or body.name == "Player"):
		AI = body


func _on_hitarea_body_exited(body: Node2D) -> void:
	AI = null
