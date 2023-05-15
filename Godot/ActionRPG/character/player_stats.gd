extends Node

@export var max_health : int = 5:
	get:
		return max_health
	set(value):
		max_health = value
		self.health = min(health, max_health)
		emit_signal("max_health_changed")

var health = max_health:
	get:
		return health
	set(value):
		health = value
		emit_signal("health_changed", health)
		if health <= 0:
			emit_signal("no_health")

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_health(value):
	health = value

func _ready():
	self.health = max_health
