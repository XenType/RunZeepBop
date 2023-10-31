extends Control

signal mouse_down
signal mouse_up

@export var prize_scene: PackedScene = null

@onready var state_machine = $CursorStateMachine as FiniteStateMachine
@onready var normal_state = $CursorStateMachine/CursorNormalState as CursorNormalState
@onready var prize_state = $CursorStateMachine/CursorPrizeState as CursorPrizeState

var prize_instance = null

func _process(delta):
	if (prize_instance != null):
		prize_instance.position = get_local_mouse_position()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.is_pressed():
			mouse_down.emit()
			state_machine.change_state(prize_state)
		elif event.button_index == 1 && not event.is_pressed():
			mouse_up.emit()
			state_machine.change_state(normal_state)

func update_cursor_icon(): # state_has_changed signal
	if state_machine.state is CursorPrizeState:
		prize_instance = prize_scene.instantiate()

		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		add_child(prize_instance)
	else:
		if (prize_instance != null):
			prize_instance.remove_from_map()
			prize_instance = null
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		

