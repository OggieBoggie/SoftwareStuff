extends CharacterBody2D

@export var move_speed : float = 100
@export var roll_distance : float = 1.5
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sword_hitbox = $SwordAttack/SwordHitBox
@onready var hurtbox = $Hurtbox

enum {
	Walk,
	Roll,
	Attack
}

var state = Walk
var roll_input = Vector2.DOWN
var stats = PlayerStats

func _ready():
	stats.no_health.connect(queue_free)
	animation_tree.active = true
	animation_tree.set("parameters/Idle/blend_position", starting_direction)
	sword_hitbox.knockback_vector = roll_input
	
func _physics_process(delta):
	match state:
		Walk:
			move_state()
		Roll:
			roll_state()
		Attack:
			attack_state()
	
func move_state():
	
	var vectors = Input.get_vector("left", "right", "up", "down")
	
	velocity = vectors * move_speed
	
	update_animation_parameters(velocity)
	
	move_and_slide()
	
	pick_new_state()
	
	if (Input.is_action_just_pressed("attack")):
		state = Attack
	
	if (Input.is_action_just_pressed("roll")):
		state = Roll
	

func roll_state():
	velocity = roll_input * roll_distance
	move_and_slide()
	state_machine.travel("Roll")
	hurtbox.start_invincibility(0.2)

func roll_state_finished():
	state = Walk

func attack_state():
	state_machine.travel("Attack")

func attack_animation_finished():
	state = Walk

func _on_hurtbox_area_entered(area):
	stats.health -= 1
	hurtbox.start_invincibility(1)
	hurtbox.create_hit_effect()
	
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		roll_input = move_input
		sword_hitbox.knockback_vector = move_input
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Attack/blend_position", move_input)
		animation_tree.set("parameters/Roll/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
