extends Node
class_name  State
@export var animation_player: AnimationPlayer 
@export var enemy: Enemy
var player : Player
signal  Transitioned

func _ready() -> void:
	player = enemy.player 
func  Enter():
	pass
func Exit():
	pass
func  Update(_delta:float):
	pass
func Physics_Update(_delta:float):
	pass
