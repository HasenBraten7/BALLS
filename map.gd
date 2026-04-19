extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var AI = get_tree().get_nodes_in_group("AI")
	if AI.size() == 0 or AI == null:
		get_tree().change_scene_to_file("res://Menues/end screen.tscn")
