extends Area2D

@export var point_sampler: PointSampler = null

func _ready():
	point_sampler.is_looping_on = true
	point_sampler.is_active = true

func _physics_process(delta):
	if (point_sampler.is_verticle_path):
		position.y = point_sampler.position.y
	else:
		position.x = point_sampler.position.x
