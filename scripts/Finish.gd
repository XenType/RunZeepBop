extends Node2D

signal load_start

func _on_button_pressed():
	load_start.emit()
