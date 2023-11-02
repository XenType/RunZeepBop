class_name CursorController
extends Control

signal mouse_down
signal mouse_up

@export var prize_scene: PackedScene = null
@export var tile_map: TileMap

@onready var state_machine = $CursorStateMachine as FiniteStateMachine
@onready var normal_state = $CursorStateMachine/CursorNormalState as CursorNormalState
@onready var prize_state = $CursorStateMachine/CursorPrizeState as CursorPrizeState

var prize_instance: LevelPrize = null

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.is_pressed():
			mouse_down.emit()
			state_machine.change_state(prize_state)
		elif event.button_index == 1 && not event.is_pressed():
			mouse_up.emit()
			state_machine.change_state(normal_state)

func get_prize_location() -> Vector2:
	if (prize_instance != null):
		return prize_instance.position
	return Vector2.ZERO

func update_cursor_icon(): # state_has_changed signal
	if state_machine.state is CursorPrizeState:
		prize_instance = prize_scene.instantiate()
		prize_instance.position = tile_map.map_to_local(tile_map.local_to_map(get_local_mouse_position()))
		#prize_instance.disable_collision(true) # --- NEED to test this with monsters, can't collide with their vision
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		add_child(prize_instance)
	else:
		if (prize_instance != null):
			prize_instance.remove_from_map()
			prize_instance = null
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		

