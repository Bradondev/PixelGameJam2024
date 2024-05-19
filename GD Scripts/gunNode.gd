extends Node2D
class_name  GunNode
@export var CurrentGun: Gun

@export var gun: Sprite2D
@export var PlayerInventory:InventoryView
@export var Ui : CanvasLayer
@export var ammoLabel :RichTextLabel
@export var player :Player


var CanShoot = true
@export var audio_stream_player: AudioStreamPlayer

@onready var bulletspawnpoint: Node2D = $bulletspawnpoint
var MouseR
var Reloading = false
var isShooting = false
@onready var reload_bar: TextureProgressBar = $"../UI/ReloadMargin/ReloadBar/Vbox/BotBar"
@onready var reload_bar_ui : HBoxContainer = $"../UI/ReloadMargin/ReloadBar"
@onready var reticle: Sprite2D =$Reticle

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if !CurrentGun: return
	
	
	if Input.is_action_pressed("Shoot") and player.CurrentGunNode == self:
		isShooting = true
		ShootGun()
	else: 
		isShooting = false
	if !isShooting:
		audio_stream_player.stop()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	UpdateAmmoText()
# Called every frame. 'delta' is the elapsed time since the previous fr
func _unhandled_input(event: InputEvent) -> void:
	
	
	if !CurrentGun or Reloading: return
	if event.is_action_pressed("Reload")  and player.CurrentGunNode == self:
		ReloadCurrentGun()
		
	
		
func ReloadCurrentGun():
	if CurrentGun.MagSize == CurrentGun.CurrentMagSize:
		print_debug("mag is full")
		return
	var price : Dictionary = {CurrentGun.BulletTypeItem: CurrentGun.MagSize - CurrentGun.CurrentMagSize}
	var items_to_check = {}
	var counts := {}
	
	
	var Bullets = PlayerInventory.inventory.consume_items(price,false,items_to_check)
	if Bullets:
		CurrentGun.LoadMag(Bullets[0].count)
	else : return
	
	reload_bar.value = 0
	reload_bar_ui.visible = true
	Reloading = true
	
	var tween  = get_tree().create_tween()
	tween.tween_property(reload_bar, "value", 100,CurrentGun.ReloadTime)
	await  tween.finished
	if !CurrentGun:
		Reloading = false
		reload_bar_ui.visible = false
		UpdateAmmoText()
		return

	Reloading = false
	reload_bar_ui.visible = false
	UpdateAmmoText()
	
func ShootGun():
	if CanShoot and not Reloading:
		
		if CurrentGun.CurrentMagSize:
			CurrentGun.CurrentMagSize -=1
			UpdateAmmoText()
		else : 
			UpdateAmmoText()
			player.SetAnim("idle")
			print_debug("out of ammo") 
			return
			
		for i in CurrentGun.ButtetCount:
			var newBullet = CurrentGun.BulletScene.instantiate()
			if CurrentGun.ButtetCount == 1:
				newBullet.rotation  = global_rotation + ApplyAccuracy()
			else:
				var arc_rad = deg_to_rad(CurrentGun.Arc)
				var increment = arc_rad / (CurrentGun.ButtetCount -1)
				newBullet.global_rotation = (
					global_rotation + increment * i -
					arc_rad / 2
					)
				newBullet.global_rotation += ApplyAccuracy()
			newBullet.currentgun = CurrentGun
			newBullet.global_position = bulletspawnpoint.global_position
			
			get_tree().root.call_deferred("add_child", newBullet)
		player.SetAnim("shoot")
		audio_stream_player.play()
		CanShoot = false
		await  get_tree().create_timer(1/CurrentGun.ROF).timeout
		CanShoot = true
func UpdateAmmoText():
	if !CurrentGun:
		ammoLabel.text = str("No gun") 
		audio_stream_player.stream = null
		return
	#gun_reticle.texture = CurrentGun.CrossHairSprite
	bulletspawnpoint.position = CurrentGun.BulletSpawnPoint
	reticle.texture = CurrentGun.CrossHairSprite
	audio_stream_player.stream = CurrentGun.ShotSound
	bulletspawnpoint.position = CurrentGun.BulletSpawnPoint
	reticle.texture = CurrentGun.CrossHairSprite
	ammoLabel.text = str(CurrentGun.CurrentMagSize) +"/" +  str(CurrentGun.MagSize) 

func ApplyAccuracy(): 
	var rng = RandomNumberGenerator.new()
	var baseAcc =  (100 -CurrentGun.Accuracy ) / 100.00
	var my_random_number = rng.randf_range(-baseAcc, baseAcc)
	return my_random_number
