extends Node2D

var playingAnim: String = "Idle"
var player
var CurrentState
var OldState
var target_position = Vector2.ZERO
var velocity = Vector2.ZERO
var bodyName: String
var exitedBodyName: String

@onready var smp = $EnemyStateMachine
@onready var DetectionArea = $DetectionArea

@export var speed: float = 100
@export var attackingRadius: float = 0.25
@export var detectionTime: float = 0.5
@export var stunnedTime: float = 1.0
@export var attackDelay: float = 0.1
@export var strength: int = 10
@export var health: int = 100

func _on_state_machine_player_entered(to):
	pass # Replace with function body.

func _on_state_machine_player_exited(from):
	pass # Replace with function body.

func _on_state_machine_player_transited(from, to):
	CurrentState = to
	OldState = from

func _on_state_machine_player_updated(state, delta):
	velocity = Vector2.ZERO
	match state:
		"Idle":
			if DetectionArea.body_entered:
				if "Player" in bodyName:
					smp.set_trigger("PlayerDetected")
			else:
				if not playingAnim == "Idle":
					play_animation("Idle")
		"PlayerDetected":
			if DetectionArea.body_exited:
				if "Player" in bodyName:
					smp.set_trigger("Idle")
			play_animation("PlayerDetectedAnim")
			wait(detectionTime)
			smp.set_trigger("Chasing")
		"Chasing":
			if not player == null:
				move_towards(player.position, speed * delta)
			if DetectionArea.body_exited:
				if "Player" in bodyName:
					smp.set_trigger("Idle")
		"Attacking":
			play_animation("AttackingAnim")
			wait(0.1)
			smp.set_trigger("Chasing")
		"Stunned":
			wait(1)
			smp.set_trigger("Idle")
		"Damaged":
			play_animation("Damaged")
			if health <= 0:
				smp.set_trigger("Dead")
			else:
				health -= 1
		"Dead":
			play_animation("Dead")
			wait(1)
			queue_free()
func play_animation(animation):
	pass

func move_towards(target, speed):
	var velocity = (target - global_position).normalized() * speed
	global_position += velocity

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _on_detection_area_body_entered(body):
	if "Player" in body.name:
		player = body
	bodyName = body.name

func _on_detection_area_body_exited(body):
	if "Player" in body.name:
		player = null
	exitedBodyName = body.name
