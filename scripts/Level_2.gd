extends Node2D

@onready var zeep_bop = $ZeepBop as ZeepBop

signal level_failure
signal level_success

func _on_cursor_controller_mouse_up():
	zeep_bop.is_prize_cursor_showing = false

func _on_cursor_controller_mouse_down():
	zeep_bop.is_prize_cursor_showing = true

func _on_zeep_bop_reached_prize():
	level_success.emit()

func _on_zeep_bop_fell_in_pit():
	level_failure.emit()

func _on_monster_killed_zeep_bop():
	level_failure.emit()

func _on_laser_beam_killed_zeep_bop():
	level_failure.emit()
