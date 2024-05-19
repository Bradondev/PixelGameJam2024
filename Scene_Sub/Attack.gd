extends State
class_name  Attack

func  Enter():
	enemy.velocity = Vector2.ZERO
	animation_player.play("attack")
	await  animation_player.animation_finished
	Transitioned.emit(self, "chase")
func Exit():
	pass
func  Update(_delta:float):
	pass
func Physics_Update(_delta:float):
	pass
