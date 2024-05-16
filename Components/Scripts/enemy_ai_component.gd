extends Node2D
class_name EnemyAIComponent

@export var MovableEntity:Entity
@export var DetectionArea:AIDetectionArea
@export var SMP:StateMachinePlayer
@export var sprite:AnimatedSprite2D

var playingAnim: String = "Idle"
var chasing:bool = false
var bodyName: String
var exitedBodyName: String
var player:Node

func _ready():
	DetectionArea.body_entered.connect(_on_detection_area_body_entered)
	DetectionArea.body_exited.connect(_on_detection_area_body_exited)
	SMP.updated.connect(_on_state_machine_player_updated)

func _process(delta):
	if chasing:
		MovableEntity.velocity = (player.position - MovableEntity.global_position).normalized() * MovableEntity.Stats.Speed * delta

# Calls depending on the state machines update
func _on_state_machine_player_updated(state, delta):
	MovableEntity.velocity = Vector2.ZERO
	match state:
		"Idle":
			chasing = false
			if player:
				SMP.set_trigger("PlayerDetected")
			if not playingAnim == "Idle":
				sprite.play_animation("Idle")
		"Chasing":
			if not player == null:
				sprite.play_animation("Chasing")
				chasing = true
			else:
				SMP.set_trigger("Idle")
		"Attacking":
			chasing = false
			sprite.play_animation("Attacking")
			wait(0.5)
			SMP.set_trigger("Chasing")
		"Damaged":
			chasing = false
			sprite.play_animation("Damaged")
			wait(0.1)
			SMP.set_trigger("Stunned")
		"Dead":
			chasing = false
			sprite.play_animation("Dead")
			wait(0.5)
			queue_free()

func wait(seconds: float) -> void:
	await(get_tree().create_timer(seconds).timeout)

func _on_detection_area_body_entered(body):
	if "Player" in body.name:
		print_debug("PlayerEntered")
		player = body
	exitedBodyName = ""
	bodyName = body.name

func _on_detection_area_body_exited(body):
	if "Player" in body.name:
		print_debug("PlayerExited")
		player = null
	bodyName = ""
	exitedBodyName = body.name
