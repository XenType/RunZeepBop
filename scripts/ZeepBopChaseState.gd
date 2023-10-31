class_name ZeepBopChaseState
extends State

@export var actor: ZeepBop
@export var point_of_view: RayCast2D
@export var is_on_left: bool = false
@export var is_above: bool = false

signal lost_prize


func _ready() -> void:
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)
	print("chase state entered")
	# this needs adjustment when final prize is seen...or we could have a different state
	# unless we just don't need these properties...
	var mousePosition = actor.get_local_mouse_position()
	is_on_left = actor.position.x > mousePosition.x
	is_above = actor.position.y < mousePosition.y
	
	
func _exit_state() -> void:
	set_physics_process(false)
	print("chase state left")
	
func _physics_process(delta):
	print("chase state active")
	if (not actor.is_prize_cursor_showing || point_of_view.is_colliding()):
		print("need to change to idle now")
		lost_prize.emit()
