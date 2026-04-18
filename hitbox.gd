class_name HitBox
extends Area2D

@export var knockback: int = 20 : set = set_knockback, get = get_knockback

func set_knockback(value: int):
	knockback= value
	
func get_knockback() -> int:
	return knockback
