class_name ZeepBopIdleState
extends State

@export var actor: ZeepBop
@export var point_of_view: RayCast2D

signal found_prize

func _enter_state() -> void:
	print("idle state entered")
	set_physics_process(true)

func _exit_state() -> void:
	print("idle state left")
	set_physics_process(false)
	
	
func _physics_process(delta):
	print("idle state active")
	if (actor.is_prize_cursor_showing && not point_of_view.is_colliding()):
		print("need to change to chase state")
		found_prize.emit()
	
