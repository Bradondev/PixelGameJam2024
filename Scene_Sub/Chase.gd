extends State
class_name  EnemyFollow
@export var move_speed := 50.0

func  Enter():
	animation_player.play("walk")
	
func  Physics_Update(delta: float) -> void:
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 12:
		enemy.velocity = direction.normalized() * move_speed 
	else:
		enemy.velocity = Vector2()

	if direction.length() > 100:
		Transitioned.emit(self, "idle")
		
	if direction.length() <  40:
		Transitioned.emit(self, "attack")
