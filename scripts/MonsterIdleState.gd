class_name MonsterIdleState
extends State

@export var actor: MonsterActor
@export var point_of_view: RayCast2D

signal found_zeep_bop

func _enter_state() -> void:
	set_physics_process(true)

func _exit_state() -> void:
	set_physics_process(false)
	
	
func _physics_process(delta):
	if (not point_of_view.is_colliding()):
		found_zeep_bop.emit()
	
