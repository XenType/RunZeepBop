extends Node

var start = preload("res://Start.tscn")
var ui = preload("res://scenes/UserInterface.tscn")
var levels = [
	preload("res://scenes/Level_1.tscn"),
	preload("res://scenes/Level_2.tscn")
]
var finish = preload("res://scenes/Finish.tscn")

@onready var interface = $UserInterface

var current_instance: Node
var current_level := 0

func show_start():
	current_level = 0
	interface.visible = false
	clear_current_instance()
	current_instance = start.instantiate()
	current_instance.connect("start_game", _start_game)
	add_child(current_instance)

func show_finish():
	interface.visible = false
	clear_current_instance()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	current_instance = finish.instantiate()
	current_instance.connect("load_start", show_start)
	add_child(current_instance)

func next_level():
	current_level += 1
	if current_level >= levels.size():
		show_finish()
	else:
		_start_game()

func clear_current_instance():
	if current_instance != null:
		if current_instance is Node:
			current_instance.queue_free()
		current_instance = null

func _ready():
	show_start()

func _start_game():
	clear_current_instance()
	setup_level()
	interface.visible = true
	add_child(current_instance)

func setup_level():
	current_instance = levels[current_level].instantiate()
	current_instance.connect("level_failure", interface.process_level_failure)
	current_instance.connect("level_success", interface.process_level_success)

func _reload_level():
	clear_current_instance()
	setup_level()
	add_child(current_instance)



# NEXT: polishing
# remove ability to cheat the ramp - when movement stops reset is_jumping
# game-over to Start screen
# additional levels
