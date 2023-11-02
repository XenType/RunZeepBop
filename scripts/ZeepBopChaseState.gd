class_name ZeepBopChaseState
extends State

@export var actor: ZeepBop
@export var point_of_view: RayCast2D

signal lost_prize

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta):
	if (not actor.is_prize_cursor_showing || point_of_view.is_colliding()):
		lost_prize.emit()

