extends Node2D
class_name EnemyAIComponent

@export var MovableEntity:Entity
@export var DetectionArea:AIDetectionArea
@export var SMP:StateMachinePlayer
@export var sprite:AnimatedSprite2D
@export var timer:Timer

var playingAnim: String = "Idle"
var bodyName: String
var exitedBodyName: String
var chasing:bool = false
var player:Node
var time:float = 0.0

func _ready():
	DetectionArea.body_entered.connect(_on_detection_area_body_entered)
	DetectionArea.body_exited.connect(_on_detection_area_body_exited)
	SMP.updated.connect(_on_state_machine_player_updated)

# Calls depending on the state machines update
func _on_state_machine_player_updated(state, delta):
	MovableEntity.velocity = Vector2.ZERO
	print_debug(state)
	match state:
		"Idle":
			chasing = false
			if player:
				change_state("Chasing")
			if not playingAnim == "Idle":
				play_animation("Idle")
		"Chasing":
			if not player == null:
				play_animation("Chasing")
				chasing = true
				if MovableEntity.position.distance_to(player.position) <= 50:
					change_state("Attacking")
			else:
				change_state("Idle")
		"Attacking":
			time += delta
			chasing = false
			play_animation("Attacking")
			change_state("Chasing")
		"Damaged":
			time += delta
			chasing = false
			play_animation("Damaged")
			change_state("Chasing")
		"Dead":
			chasing = false
			play_animation("Dead")
			change_state("Dead")
			MovableEntity.kill_entity()
	if chasing and player:
		MovableEntity.velocity = (player.position - MovableEntity.global_position).normalized() * MovableEntity.Stats.Speed * delta
	if MovableEntity.velocity.x < 0:
		sprite.flip_h = true
	if MovableEntity.velocity.x > 0:
		sprite.flip_h = false

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

func play_animation(animation:String):
	sprite.animation = animation
	playingAnim = animation

func change_state(state:String):
	SMP.set_trigger(state)
