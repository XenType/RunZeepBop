class_name ZeepBop
extends CharacterBody2D

@export var speed := 1
@export var is_prize_cursor_showing := false

@onready var state_machine = $StateMachine as FiniteStateMachine
@onready var chase_state = $StateMachine/ZeepBopChaseState as ZeepBopChaseState
@onready var idle_state = $StateMachine/ZeepBopIdleState as ZeepBopIdleState
@onready var point_of_view = $PointOfView as RayCast2D

func _ready():
	idle_state.found_prize.connect(state_machine.change_state.bind(chase_state))
	chase_state.lost_prize.connect(state_machine.change_state.bind(idle_state))
	# hook up animation change here if needed
	state_machine.change_state(idle_state)

func _physics_process(delta):
	point_of_view.target_position = get_local_mouse_position()
	
	if state_machine.state is ZeepBopChaseState:
		move_to_prize()

func move_to_prize():
	velocity = point_of_view.target_position * speed
	move_and_slide()
