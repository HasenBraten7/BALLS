class_name HurtBox

extends Area2D

signal reveived_damage(Knockback: int)

func _ready() -> void:
		connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		reveived_damage.emit(hitbox.get_knockback())
		get_parent().take_damage(2, global_position, hitbox)
