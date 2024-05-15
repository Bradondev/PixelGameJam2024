extends CharacterBody2D

# Variables for managing animations, states, and movement
var playingAnim: String = "Idle"
var player
var CurrentState
var OldState
var target_position = Vector2.ZERO
var bodyName: String
var exitedBodyName: String
var damageAmount: int
var chasing: bool = false

# References to other nodes in the scene
@onready var smp = $EnemyStateMachine
@onready var DetectionArea = $DetectionArea
@onready var animatedSprite = $AnimatedSprite2D

# Exported variables for tuning enemy behavior
@export var speed: float = 1000.0
@export var attackingRadius: float = 0.25
@export var detectionTime: float = 0.5
@export var stunnedTime: float = 1.0
@export var attackDelay: float = 0.1
@export var strength: int = 10
@export var health: int = 100
@export var stunned: bool = false
@export var nineMMDamage: int = 25

# Called when the player enters a state
func _on_state_machine_player_entered(to):
	pass # Replace with function body.

# Called when the player exits a state
func _on_state_machine_player_exited(from):
	pass # Replace with function body.

# Called when the player transitions between states
func _on_state_machine_player_transited(from, to):
	CurrentState = to
	OldState = from

# Calls depending on the state machines update
func _on_state_machine_player_updated(state, delta):
	velocity = Vector2.ZERO
	print_debug(state)
	match state:
		"Idle":
			chasing = false
			if DetectionArea.body_entered:
				if "Player" in bodyName:
					smp.set_trigger("PlayerDetected")
			if not playingAnim == "Idle":
				play_animation("Idle")
		"PlayerDetected":
			chasing = false
			if DetectionArea.body_exited:
				if "Player" in exitedBodyName:
					smp.set_trigger("Idle")
			play_animation("PlayerDetected")
			wait(detectionTime)
			smp.set_trigger("Chasing")
		"Chasing":
			if not player == null:
				chasing = true
			if DetectionArea.body_exited:
				if "Player" in exitedBodyName:
					smp.set_trigger("Idle")
			if stunned:
				smp.set_trigger("Stunned")
		"Attacking":
			chasing = false
			if DetectionArea.body_exited:
				if "Player" in exitedBodyName:
					smp.set_trigger("Idle")
			play_animation("Attacking")
			wait(0.1)
			player.TakeDamage(strength)
			smp.set_trigger("Chasing")
		"Stunned":
			chasing = false
			if DetectionArea.body_exited:
				if "Player" in exitedBodyName:
					smp.set_trigger("Idle")
			wait(stunnedTime)
			stunned = false
			smp.set_trigger("Idle")
		"Damaged":
			chasing = false
			play_animation("Damaged")
			if health <= 0:
				smp.set_trigger("Dead")
			else:
				health -= damageAmount
				smp.set_trigger("Idle")
		"Dead":
			chasing = false
			play_animation("Dead")
			wait(0.5)
			queue_free()

func _process(delta):
	if chasing and not player == null:
		velocity = (player.position - global_position).normalized() * speed * delta
	move_and_slide()

# Play an animation and update the current animation state
func play_animation(animation):
	animatedSprite.play(animation)
	playingAnim = animation
	
	# Rotate Sprite depending on direction moving
	if velocity.x > 0:
		animatedSprite.flip_h = false
	elif velocity.x < 0:
		animatedSprite.flip_h = true

# Wait for a specified duration
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_detection_area_body_entered(body):
	if "Player" in body.name:
		player = body
	exitedBodyName = ""
	bodyName = body.name

func _on_detection_area_body_exited(body):
	if "Player" in body.name:
		player = null
	bodyName = ""
	exitedBodyName = body.name

func take_damage(amount:int):
	damageAmount = amount
	smp.set_trigger("Damaged")

func _on_hurt_box_collision(area_rid, area, area_shape_index, local_shape_index):
	if "9MmBullet" in area.get_parent().name:
		take_damage(nineMMDamage)
