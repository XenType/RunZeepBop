class_name LevelPrize
extends Area2D

@export var is_cursor := false

func remove_from_map():
	queue_free()

func disable_collision(should_disable: bool) -> void:
	$Collision.disabled = should_disable
