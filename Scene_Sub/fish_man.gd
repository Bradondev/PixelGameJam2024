extends CharacterBody2D
class_name Enemy
@export var BaseDamage : int = 20
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var player : CharacterBody2D
@onready var state_machine: Node = $"State Machine"
@onready var attack: Attack = $"State Machine/Attack"


@export var CurrentHealth : int = 100

func _physics_process(delta: float) -> void:
	move_and_slide()

	if velocity.length() > 0:
		animation_player.play("walk")
		
	
	if velocity.x > 0 and  !state_machine.current_state == $"State Machine/Attack":
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true


func _on_attack_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("TakeDamage") and body != self:
		body.TakeDamage(BaseDamage)

func  TakeDamage(Amount):
	CurrentHealth -= Amount
	if CurrentHealth <= 0:
		queue_free()
