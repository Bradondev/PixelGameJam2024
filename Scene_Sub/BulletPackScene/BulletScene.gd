extends CharacterBody2D


var SPEED = 500
var Dir = Vector2.RIGHT
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _ready() -> void:
	Dir = Vector2.RIGHT.rotated(global_rotation)
	
func _physics_process(delta: float) -> void:
	velocity =Dir * SPEED *delta
	var collison = move_and_collide(velocity)
	
	if collison:
		sprite_2d.play("OnHit")
		await  get_tree().create_timer(.3).timeout
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()







func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("TakeDamage"):
		body.TakeDamage(2)
