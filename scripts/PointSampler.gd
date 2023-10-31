class_name PointSampler
extends PathFollow2D

@export var path_speed := 2.0
@export var is_increasing_progress := true
@export var path_length := 0
@export var is_verticle_path := false
@export var is_active := false
@export var is_looping_on := false
# handle turning on and off looping as well as timer

var start_location: Vector2
var end_location: Vector2
var start_progress := 0
var end_progress := 0

func _ready():
	var start_ratio = progress_ratio
	
	progress_ratio = 0
	start_location = position
	start_progress = progress
	
	progress_ratio = 1
	end_location = position
	end_progress = progress
	
	progress_ratio = start_ratio
	
	is_verticle_path = start_location.x == end_location.x
	path_length = abs(end_location.y - start_location.y) if (is_verticle_path) else abs(end_location.x - start_location.x)


func _on_timer_timeout():
	if (is_active):
		var newProgress = progress + path_speed if is_increasing_progress else progress - path_speed	
		
		if newProgress > end_progress:
			newProgress = end_progress
			if is_looping_on:
				is_increasing_progress = false
		if newProgress < start_progress:
			newProgress = start_progress
			if is_looping_on:
				is_increasing_progress = true
		
		progress = newProgress
