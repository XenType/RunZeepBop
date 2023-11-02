extends Area2D

signal killed_zeep_bop

@export var point_sampler: PointSampler = null

func _ready():
	point_sampler.is_looping_on = true
	point_sampler.is_active = true

func _physics_process(delta):
	if (point_sampler.is_verticle_path):
		position.y = point_sampler.position.y
	else:
		position.x = point_sampler.position.x


func _on_body_entered(body):
	if (body.is_in_group("Player")):
		killed_zeep_bop.emit()
