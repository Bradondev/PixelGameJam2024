extends Control
class_name  LoadScene
@onready var load_bar: TextureProgressBar = $ColorRect/Center/Vbox/Center/LoadBar
@export var Scene : PackedScene
# Called when the node enters the scene tree for the first time.
func StartLoading():
	show()
	var tween  = get_tree().create_tween()
	tween.tween_property(load_bar, "value", 100,1)
	await  tween.finished
	LoadNewScene()
	pass
func LoadNewScene():
	get_tree().change_scene_to_packed(Scene)
	pass
