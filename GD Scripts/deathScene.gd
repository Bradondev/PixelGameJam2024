extends Node2D
class_name  DeathScene
@export var player : Player
@export var animation_player: AnimationPlayer 
@export var load_screen_1: LoadScene 
@export var deathmusic: AudioStreamPlayer 
@export var maledeathsound: AudioStreamPlayer 

func PlayDeath():
	visible = true
	deathmusic.play()
	maledeathsound.play()
	player.composite_sprite.visible = false
	player.get_parent().process_mode = Node.PROCESS_MODE_DISABLED
	animation_player.play("death/death", -1 , .25)





func _on_return_to_hub_pressed() -> void:
	load_screen_1.StartLoading()
