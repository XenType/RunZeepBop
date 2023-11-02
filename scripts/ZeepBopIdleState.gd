class_name ZeepBopIdleState
extends State

@export var actor: ZeepBop
@export var point_of_view: RayCast2D

signal found_prize

	
func _physics_process(delta):
	if (actor.is_prize_cursor_showing && not point_of_view.is_colliding()):
		found_prize.emit()
	
