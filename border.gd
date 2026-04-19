extends Node


func _on_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai'):
		body.queue_free()
	if  body.d_name == 'Player':
		get_tree().change_scene_to_file("res://Menues/Game_Over.tscn")

func _on_border_bottom_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai'):
		body.queue_free()
	if  body.d_name == 'Player':
		get_tree().change_scene_to_file("res://Menues/Game_Over.tscn")

func _on_border_left_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai'):
		body.queue_free()
	if  body.d_name == 'Player':
		get_tree().change_scene_to_file("res://Menues/Game_Over.tscn")

func _on_border_right_body_entered(body: Node2D) -> void:
	if(body.d_name == 'Ai'):
		body.queue_free()
	if  body.d_name == 'Player':
		get_tree().change_scene_to_file("res://Menues/Game_Over.tscn")
