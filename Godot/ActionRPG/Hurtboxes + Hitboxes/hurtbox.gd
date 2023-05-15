extends Area2D

const hit_effect = preload("res://Effects/hit_effect.tscn")

@onready var timer = $Timer
@onready var collision_shape = $CollisionShape2D

signal invincibility_started
signal invincibility_ended

func create_hit_effect():
	var effect = hit_effect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func start_invincibility(duration):
	emit_signal("invincibility_started")
	timer.start(duration)

func _on_timer_timeout():
	emit_signal("invincibility_ended")

func _on_invincibility_started():
	collision_shape.set_deferred("disabled", true)
	
func _on_invincibility_ended():
	collision_shape.disabled = false
