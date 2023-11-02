class_name MonsterChaseState
extends State

@export var actor: MonsterActor
@export var point_of_view: RayCast2D
@export var is_on_left: bool = false
@export var is_above: bool = false

signal lost_zeep_bop

func _ready() -> void:
	set_physics_process(false)
	
func _physics_process(delta):
	var local_position = actor.to_local(actor.zeep_bop.position)
	is_on_left = local_position.x < 0 # STOPPED HERE
	is_above = local_position.y > 0
	if (point_of_view.is_colliding()):
		lost_zeep_bop.emit()

