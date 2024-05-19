extends CharacterBody2D
class_name Enemy
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var player : CharacterBody2D
func _physics_process(delta: float) -> void:
	move_and_slide()

	if velocity.length() > 0:
		animation_player.play("walk")
	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
