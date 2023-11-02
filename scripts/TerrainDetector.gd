extends Area2D

@export var collision_source: CollisionShape2D

signal ramp_collision
signal pit_collision
signal prize_collision

func _ready():
	if collision_source != null:
		$Collision.shape = collision_source.shape


func _on_body_shape_entered(body_rid, body: Node2D, body_shape_index, local_shape_index):
	if body is TileMap:
		var tile_reference = body.get_coords_for_body_rid(body_rid)
		for index in body.get_layers_count():
			var tile_data = body.get_cell_tile_data(index, tile_reference)
			if tile_data is TileData:
				if tile_data.get_custom_data("isPit"):
					pit_collision.emit()
				if tile_data.get_custom_data("isRamp"):
					ramp_collision.emit()
				if tile_data.get_custom_data("isFinish"):
					prize_collision.emit()
