extends State
class_name  EnemyIdle



@export var move_speed := 10.0
var move_direction : Vector2
var wander_time : float

func  randomize_wander():
	move_direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
	
	

func  Enter():
	animation_player.play("walk")
	randomize_wander()
	
func Exit():
	pass
	
func  Update(_delta:float):
	if wander_time > 0:
		wander_time -= _delta
	else :
		randomize_wander()
		
		
func Physics_Update(_delta:float):
	if enemy: 
		enemy.velocity = move_direction * move_speed 
		
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 60:
		Transitioned.emit(self, "chase")
