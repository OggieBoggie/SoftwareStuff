extends CharacterBody2D

const enemy_death_effect = preload("res://Effects/enemy_death_effect.tscn")

@export var move_speed: float = 100
@export var acceleration: float = 5000

@onready var sprite = $AnimatedSprite2D
@onready var stats = $Stats
@onready var playerDetectionZone = $PlayerDetectionZone
@onready var hurtbox = $Hurtbox
@onready var soft_collision = $SoftCollision

enum {
	Idle,
	Wander,
	Chase
}

var state = Idle

var idle = Vector2.ZERO
var knockback = Vector2.ZERO

func _ready():
	sprite.play("animate")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	move_and_collide(knockback)
	
	match state:
		Idle:
			velocity = idle.move_toward(Vector2.ZERO, 200 * delta)
			seek_player()
		Wander:
			pass
		Chase:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = idle.move_toward(direction * move_speed, acceleration * delta)
				move_and_slide()
			sprite.flip_h = velocity.x < 0
			

func seek_player():
	if playerDetectionZone.can_see_player():
		state = Chase

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 0.25
	hurtbox.create_hit_effect()

func _on_stats_no_health():
	queue_free()
	var death_effect = enemy_death_effect.instantiate()
	get_parent().add_child(death_effect)
	death_effect.global_position = global_position
