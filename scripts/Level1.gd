extends Node2D

@onready var zeep_bop = $ZeepBop as ZeepBop


# Next work on Zeep Bops movement a bit, especially on corners
# Then setup existing trap collision

func _on_cursor_controller_mouse_up():
	zeep_bop.is_prize_cursor_showing = false


func _on_cursor_controller_mouse_down():
	zeep_bop.is_prize_cursor_showing = true
