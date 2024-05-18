extends Node2D

'''
Bottom sprite = Legs only // 1=9 for walking, 9 for shooting (exception of pistol shooting, which uses 0) // Swap this out for different pant equipment
Body sprite = Head and torso
Chest sprite = For equipped chest piece
Arms sprite = Arms only, designed to show arm infront of guns
Helmet sprite = For equipped head piece

Gun sprite = Gun, bullet, and gun fire effect // This texture can be swapped out to showcase different guns using the dict below
'''



var gun_color = {
	
	"desert" : load("res://Art_PNG/Player_CompositeSprite_SpriteSheet_Gun_Desert.png"),
	"artic" : load("res://Art_PNG/Player_CompositeSprite_SpriteSheet_Gun_Artic.png"), 
	"camo" : load("res://Art_PNG/Player_CompositeSprite_SpriteSheet_Gun_Camo.png"),
	
}

var gun_reticle = {
	
	"pistol" : load("res://Art_UI/Gun_Reticle, Pistol v1.png"),
	"smg" : load("res://Art_UI/Gun_Reticle, SMG.png"),
	"ar" : load("res://Art_UI/Gun_Reticle, Assault Rifle.png"),
	"shotty" : load("res://Art_UI/Gun_Reticle, Shotgun v1.png"),
	"sniper" : load("res://Art_UI/Gun_Reticle, Sniper.png"),
	
}

@export var testing = true
@export var test_animation = "shoot_R_sniper"
@export var guns_color =  "artic"
@export var guns_reticle = "ar" 

var testing_gunColor = gun_color[guns_color]
var testing_gunReticle = gun_reticle[guns_reticle]
@onready var sprite_player: AnimationPlayer = $SpritePlayer
@onready var gun: Sprite2D = $Sprites/Gun


func AnimPlayer(AnimationName, Frame):
	sprite_player.play(AnimationName,Frame)




func _process(delta):
	if testing == true:
		$ReticleArm.look_at(get_global_mouse_position())
		$SpritePlayer.play(test_animation)

func _ready():
	_cameraToggle(testing)

func _cameraToggle(status):
	$"Camera (testing)".enabled = status
	if status == true:
		$ReticleArm/Reticle.texture = testing_gunReticle
		$Sprites/Gun.texture = testing_gunColor
	else: 
		pass