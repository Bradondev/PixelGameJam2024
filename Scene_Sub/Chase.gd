extends State
class_name  EnemyFollow
@export var move_speed := 50.0


	
func  Physics_Update(delta: float) -> void:
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > 12:
		enemy.velocity = direction.normalized() * move_speed 
	else:
		enemy.velocity = Vector2()

	if direction.length() > 80:
		Transitioned.emit(self, "idle")
