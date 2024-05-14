extends CharacterBody2D


var SPEED = 1
var Dir = Vector2.RIGHT

func _ready() -> void:
	Dir = Vector2.RIGHT.rotated(global_rotation)
	
func _process(delta: float) -> void:
	velocity =Dir * SPEED
	var collison = move_and_collide(velocity)
	
	if collison:
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
