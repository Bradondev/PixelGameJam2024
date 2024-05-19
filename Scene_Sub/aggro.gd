extends State
class_name Aggro

@export var move_speed := 60.0
func  Enter():
	await  get_tree().create_timer(3).timeout
	Transitioned.emit(self, "idle")
func Exit():
	pass
func  Update(_delta:float):
	pass
func Physics_Update(_delta:float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 12:
		enemy.velocity = direction.normalized() * move_speed 
	else:
		enemy.velocity = Vector2()

	if direction.length() <  30:
		Transitioned.emit(self, "attack")
