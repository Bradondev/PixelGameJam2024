extends Area2D

@onready var damageTime:float = get_parent().attackDelay

@export var enabled:bool = false

func _on_area_entered(area):
	if "Player" in area.get_parent().name:
		area.get_parent().TakeDamage(get_parent().strength)

func enableDamage():
	get_child(0).set_deferred("Disabled", false)
	wait(damageTime)
	get_child(0).set_deferred("Disabled", true)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
