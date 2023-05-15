
extends Control

@onready var hearts = 5:
	get:
		return hearts
	set(value):
		hearts = value

@onready var max_hearts = 5:
	get:
		return max_hearts
	set(value):
		max_hearts = value

@onready var heart_full = $HeartUIFull
@onready var heart_empty = $HeartUIEmpty

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heart_full != null:
		heart_full.set_size(Vector2(hearts * 15, 11))

func set_max_health(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heart_empty != null:
		heart_empty.set_size(Vector2(max_hearts * 15, 11))

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health
	PlayerStats.health_changed.connect(set_hearts)
	PlayerStats.max_health_changed.connect(set_max_health)

