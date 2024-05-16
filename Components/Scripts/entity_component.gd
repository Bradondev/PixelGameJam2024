extends CharacterBody2D
class_name Entity

@export var Stats:StatResource
@export var HealthComponent:HealthComponent
@export var DeathEffect:EffectResource

func kill_entity():
	print_debug("Entity Killed!")
	if DeathEffect:
		DeathEffect.trigger_effect(self)
		queue_free()
	else:
		queue_free()

func _process(delta):
	move_and_slide()
