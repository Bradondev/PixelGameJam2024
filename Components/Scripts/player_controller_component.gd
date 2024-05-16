extends Node2D
class_name PlayerControllerComponent

@export var MovableEntity:Entity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('ui_right'):
		input.x += 1
	if Input.is_action_pressed('ui_left'):
		input.x -= 1
	if Input.is_action_pressed('ui_down'):
		input.y += 1
	if Input.is_action_pressed('ui_up'):
		input.y -= 1
	return input

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_input()
	if direction.length() > 0:
		MovableEntity.velocity = MovableEntity.velocity.lerp(direction.normalized() * MovableEntity.Stats.Speed, MovableEntity.Stats.Acceleration)
	else:
		MovableEntity.velocity = MovableEntity.velocity.lerp(Vector2.ZERO, MovableEntity.Stats.Friction)
