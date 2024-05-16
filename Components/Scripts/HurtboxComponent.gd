extends Area2D
class_name HurtboxComponent

@export var attack:Attack

var attackDamage
var stunTime
var knockbackForce
var attackPosition

# Called when the node enters the scene tree for the first time.
func _ready():
	attackDamage = attack.AttackDamage
	stunTime = attack.StunTime
	knockbackForce = attack.KnockbackForce
	attackPosition = global_position
