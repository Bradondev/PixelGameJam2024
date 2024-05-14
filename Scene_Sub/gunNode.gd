extends Node2D

@export var CurrentGun: Gun
@export var gun: Sprite2D
@export var PlayerInventory:InventoryView
@export var Ui : CanvasLayer
@export var ammoLabel :RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UpdateGunSprite()
	UpdateAmmoText()
# Called every frame. 'delta' is the elapsed time since the previous fr
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("Shoot"):
		ShootGun()
	if event.is_action_pressed("Reload"):
		ReloadCurrentGun()
		
func ReloadCurrentGun():
	
	var price : Dictionary = {CurrentGun.BulletType: CurrentGun.MagSize}
	var items_to_check = {}
	var counts := {}
	
	
	var Bullets = PlayerInventory.inventory.consume_items(price,false,items_to_check)
	if Bullets:
		CurrentGun.LoadMag(Bullets[0].count)
	else : print_debug("out of ammo")
	UpdateAmmoText()
func ShootGun():
	if CurrentGun.CurrentMagSize:
		CurrentGun.CurrentMagSize -=1
		print_debug(CurrentGun.CurrentMagSize)
	else : print_debug("out of ammo")
	UpdateAmmoText()

func UpdateAmmoText():
	ammoLabel.text = str(CurrentGun.CurrentMagSize) +"/" +  str(CurrentGun.MagSize) 
func UpdateGunSprite():
	gun.texture = CurrentGun.Sprite
