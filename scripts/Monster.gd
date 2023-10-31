class_name MonsterActor
extends Area2D

signal killed_zeep_bop

@export var zeep_bop: ZeepBop
@export var point_sampler: PointSampler = null

@onready var state_machine = $SightStateMachine as FiniteStateMachine
@onready var point_of_view = $PointOfView as RayCast2D
@onready var idle_state = $SightStateMachine/MonsterIdleState as MonsterIdleState
@onready var chase_state = $SightStateMachine/MonsterChaseState as MonsterChaseState

func _ready():
	idle_state.found_zeep_bop.connect(state_machine.change_state.bind(chase_state))
	chase_state.lost_zeep_bop.connect(state_machine.change_state.bind(idle_state))
	state_machine.state_has_changed.connect(update_animation)
	state_machine.change_state(idle_state)
	point_sampler.is_active = false
	point_sampler.is_looping_on = false

	
func _physics_process(delta):
	
	$PointOfView.target_position = zeep_bop.position
	
	if state_machine.state is MonsterChaseState:
		point_sampler.is_active = true
		point_sampler.is_increasing_progress = true if ((point_sampler.is_verticle_path && chase_state.is_above) || (not point_sampler.is_verticle_path && not chase_state.is_on_left)) else false
		chase_zeep_bop()
	else:
		point_sampler.is_active = false
		
func update_animation():
	if state_machine.state is MonsterChaseState:
		if (state_machine.state.is_on_left):
			$HeadSprite.play("chase_left")
		else:
			$HeadSprite.play("chase_right")
		$BodySprite.play("chase")
	else:
		$HeadSprite.play("idle")
		$BodySprite.play("idle")
		
func chase_zeep_bop():
	if point_sampler.is_verticle_path:
		position.y = point_sampler.position.y
	else:
		position.x = point_sampler.position.x
	
	

	
