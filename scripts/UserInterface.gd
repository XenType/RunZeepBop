class_name MainUserInterface
extends Control

signal load_start
signal reload_level
signal load_next_level

@onready var state_machine = $GameState as FiniteStateMachine
@onready var active_state = $GameState/GameStateActive as State
@onready var try_again_state = $GameState/GameStateTryAgain as State
@onready var game_over_state = $GameState/GameStateGameOver as State
@onready var game_over_button = $GameOver as Button
@onready var try_again_button = $TryAgain as Button
@onready var next_level_button = $NextLevel as Button
@onready var shade_out = $ShadeOut as ColorRect
@onready var life_1 = $Lives/Life1 as Sprite2D
@onready var life_2 = $Lives/Life2 as Sprite2D
@onready var life_3 = $Lives/Life3 as Sprite2D
@onready var button_backer = $ButtonBacker as ColorRect

var lives := 3
const max_lives = 3

func _ready():
	state_machine.change_state(active_state)
	

func _on_game_state_state_has_changed():
	if state_machine is FiniteStateMachine:
		match state_machine.state:
			active_state:
				set_active_display()
			try_again_state:
				set_failure_display(true)
			game_over_state:
				set_failure_display(false)
	
func set_active_display():
	shade_out.visible = false
	button_backer.visible = false
	game_over_button.visible = false
	try_again_button.visible = false
	next_level_button.visible = false
	get_tree().paused = false
	
func set_failure_display(can_try_again):
	shade_out.visible = true
	button_backer.visible = true
	game_over_button.visible = not can_try_again
	try_again_button.visible = can_try_again
	next_level_button.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	
func set_success_display():
	shade_out.visible = true
	button_backer.visible = true
	game_over_button.visible = false
	try_again_button.visible = false
	next_level_button.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	
func update_life_display():
	life_1.visible = lives > 0
	life_2.visible = lives > 1
	life_3.visible = lives > 2

func process_level_failure():
	lives = lives - 1
	update_life_display()
	state_machine.change_state(try_again_state if lives > 0 else game_over_state)
	
func process_level_success():
	lives = lives + 1 if lives < max_lives else max_lives
	update_life_display()
	set_success_display()

func _on_try_again_pressed():
	reload_level.emit()
	state_machine.change_state(active_state)
	
func _on_game_over_pressed():
	load_start.emit()
	lives = max_lives


func _on_next_level_pressed():
	load_next_level.emit()
	state_machine.change_state(active_state)
