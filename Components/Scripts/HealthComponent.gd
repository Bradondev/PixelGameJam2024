extends Node2D
class_name HealthComponent

@onready var Stats = get_parent().Stats

var maxHealth:int
var health:int

@export var Entity:Entity

# Called when the node enters the scene tree for the first time.
func _ready():
	maxHealth = Stats.Health
	health = maxHealth

func damage(attack:Attack):
	health -= attack.AttackDamage
	
	if health <= 0:
		if Entity.has_method("kill_entity"):
			Entity.kill_entity()
