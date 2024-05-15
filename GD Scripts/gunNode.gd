extends Node2D

@export var CurrentGun: Gun
@export var gun: Sprite2D
@export var PlayerInventory:InventoryView
@export var Ui : CanvasLayer
@export var ammoLabel :RichTextLabel
var CanShoot = true
@onready var bulletspawnpoint: Marker2D = $bulletspawnpoint
var MouseR

@onready var gun_reticle: Sprite2D = $gunReticle

func _physics_process(delta: float) -> void:
	if !CurrentGun: return
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("Shoot"):
		ShootGun()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	UpdateAmmoText()
# Called every frame. 'delta' is the elapsed time since the previous fr
func _unhandled_input(event: InputEvent) -> void:
	if !CurrentGun: return
	if event.is_action_pressed("Reload"):
		ReloadCurrentGun()
		
func ReloadCurrentGun():
	
	var price : Dictionary = {CurrentGun.BulletTypeItem: CurrentGun.MagSize}
	var items_to_check = {}
	var counts := {}
	
	
	var Bullets = PlayerInventory.inventory.consume_items(price,false,items_to_check)
	if Bullets:
		CurrentGun.LoadMag(Bullets[0].count)
	else : print_debug("out of ammo")
	UpdateAmmoText()
func ShootGun():
	if CanShoot:
		
		if CurrentGun.CurrentMagSize:
			CurrentGun.CurrentMagSize -=1
			print_debug(CurrentGun.CurrentMagSize)
			UpdateAmmoText()
		else : 
			UpdateAmmoText()
			print_debug("out of ammo") 
			return
		for i in CurrentGun.ButtetCount:
			var newBullet = CurrentGun.BulletScene.instantiate()
			newBullet.position =global_position
			if CurrentGun.ButtetCount == 1:
				newBullet.rotation  = global_rotation
			else:
				var arc_rad = deg_to_rad(CurrentGun.Arc)
				var increment = arc_rad / (CurrentGun.ButtetCount -1)
				newBullet.global_rotation = (
					global_rotation + increment * i -
					arc_rad / 2
					)
			get_tree().root.call_deferred("add_child", newBullet)
		CanShoot = false
		await  get_tree().create_timer(1/CurrentGun.ROF).timeout
		CanShoot = true
func UpdateAmmoText():
	if !CurrentGun:
		ammoLabel.text = str("No gun") 
		gun_reticle.texture = null
		gun.texture = null
		return
	gun_reticle.texture = CurrentGun.CrossHairSprite
	bulletspawnpoint.global_position = CurrentGun.BulletSpawnPoint
	UpdateGunSprite()
	ammoLabel.text = str(CurrentGun.CurrentMagSize) +"/" +  str(CurrentGun.MagSize) 
func UpdateGunSprite():
	gun.texture = CurrentGun.Sprite
