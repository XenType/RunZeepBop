class_name MonsterChaseState
extends State

@export var actor: MonsterActor
@export var point_of_view: RayCast2D
@export var is_on_left: bool = false
@export var is_above: bool = false

signal lost_zeep_bop

func _ready() -> void:
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)

	is_on_left = actor.zeep_bop.position.x < 0
	is_above = actor.zeep_bop.position.y > 0
	
	
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	if (point_of_view.is_colliding()):
		lost_zeep_bop.emit()

