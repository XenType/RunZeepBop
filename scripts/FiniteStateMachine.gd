class_name FiniteStateMachine
extends Node

signal state_has_changed

@export var state: State

func _ready():
	change_state(state)

func change_state(newState: State):
	if state is State:
		state._exit_state()
	if newState is State:
		newState._enter_state()
		state = newState
		state_has_changed.emit()
