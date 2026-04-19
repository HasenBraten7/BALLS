extends Node


func _on_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai' or body.d_name == 'Player'):
		body.queue_free()


func _on_border_bottom_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai' or body.d_name == 'Player'):
		body.queue_free()


func _on_border_left_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai' or body.d_name == 'Player'):
		body.queue_free()


func _on_border_right_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai' or body.d_name == 'Player'):
		body.queue_free()
