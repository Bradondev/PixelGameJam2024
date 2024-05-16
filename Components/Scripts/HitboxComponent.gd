extends Area2D
class_name HitboxComponent

@export var HealthComponent:HealthComponent
var attack:Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if area is HurtboxComponent:
		attack = Attack.new()
		attack.AttackDamage = area.attackDamage
		attack.KnockbackForce = area.knockbackForce
		attack.StunTime = area.stunTime
		attack.AttackPosition = area.global_position
		
		HealthComponent.damage(attack)
