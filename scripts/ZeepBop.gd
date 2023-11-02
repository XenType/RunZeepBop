class_name ZeepBop
extends CharacterBody2D

signal fell_in_pit
signal reached_prize

@export var level_prize: LevelPrize
@export var cursor_controller: CursorController
@export var is_prize_cursor_showing := false
@export var max_speed := 250.0
@export var acceleration := 10.0

const min_jump_speed = 150.0
var speed = 1.0
var is_jumping = false

@onready var state_machine = $StateMachine as FiniteStateMachine
@onready var chase_state = $StateMachine/ZeepBopChaseState as ZeepBopChaseState
@onready var idle_state = $StateMachine/ZeepBopIdleState as ZeepBopIdleState
@onready var point_of_view = $PointOfView as RayCast2D
@onready var prize_point_of_view = $PrizePointOfView as RayCast2D

func _ready():
	set_physics_process(false)
	idle_state.found_prize.connect(state_machine.change_state.bind(chase_state))
	chase_state.lost_prize.connect(state_machine.change_state.bind(idle_state))
	state_machine.state_has_changed.connect(update_animation)
	state_machine.change_state(idle_state)


func _process(delta):
	if (cursor_controller == null && state_machine.state is ZeepBopIdleState):
		is_prize_cursor_showing = true
		state_machine.change_state(chase_state)
	
	prize_point_of_view.target_position = prize_point_of_view.to_local(level_prize.position)
	if not prize_point_of_view.is_colliding():
		is_prize_cursor_showing = true
		point_of_view.target_position = prize_point_of_view.target_position
		speed = max_speed
		move_to_prize()
	else:
		var prize_location = cursor_controller.get_prize_location()
		if (prize_location != Vector2.ZERO):
			point_of_view.target_position = point_of_view.to_local(prize_location)
		else:
			point_of_view.target_position = Vector2.ZERO
		if state_machine.state is ZeepBopChaseState:
			move_to_prize()
			speed += acceleration
			if speed > max_speed:
				speed = max_speed
		else:
			speed = 1

func _physics_process(delta):
	move_and_slide()

func update_animation():
	if state_machine.state is ZeepBopChaseState:
		$Animation.play("chase")
	else:
		$Animation.play("idle")

func move_to_prize():
	var target_position = point_of_view.to_global(point_of_view.target_position)
	velocity = position.direction_to(target_position) * speed
	if (position.distance_to(target_position) < 5):
		speed = 1.0
		velocity = Vector2.ZERO	

	
func _on_state_machine_state_has_changed():
	if (state_machine != null):
		set_physics_process(state_machine.state is ZeepBopChaseState)
	

func _on_terrain_detector_ramp_collision():
	is_jumping = speed >= min_jump_speed


func _on_terrain_detector_pit_collision():
	if is_jumping:
		is_jumping = false
	else:
		fell_in_pit.emit()


func _on_terrain_detector_prize_collision():
	reached_prize.emit()
