extends CharacterBody2D


var speed = 50



func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _process(_delta):
	get_input()
	move_and_slide()
