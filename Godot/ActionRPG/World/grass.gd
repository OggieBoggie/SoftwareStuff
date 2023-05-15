extends Node2D

const grass_effect = preload("res://Effects/grass_effect.tscn")

func create_grass_effect():
	var effect = grass_effect.instantiate()
	var world = get_tree().current_scene
		
	world.add_child(effect)
		
	effect.global_position = global_position

func _on_hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
