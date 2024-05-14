extends CharacterBody2D



@export var inventory: Control

@export var speed :int = 400  # speed in pixels/sec
@export var CurrentGun: Gun
@export var gun: Sprite2D
@export var PlayerInventory:InventoryView


func  _ready() -> void: 
	UpdateGunSprite()

func _physics_process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_inventory"):
		FlipInventory()
		
	if event.is_action_pressed("Reload"):
		ReloadCurrentGun()
		
	if event.is_action("Shoot"):
		ShootGun()
func UpdateGunSprite():
	gun.texture = CurrentGun.Sprite


func ShootGun():
	if CurrentGun.CurrentMagSize:
		CurrentGun.CurrentMagSize -=1
		print_debug(CurrentGun.CurrentMagSize)
	else : print_debug("out of ammo")
	
func FlipInventory():
	if !inventory.visible:inventory.show()
	else: inventory.hide()
func ReloadCurrentGun():
	
	var price : Dictionary = {CurrentGun.BulletType: CurrentGun.MagSize}
	var items_to_check = {}
	var counts := {}
	print_debug(PlayerInventory.inventory.consume_items(price,false,items_to_check))
	#var Bullets =  
	#if Bullets:
	#	CurrentGun.LoadMag(CurrentGun.MagSize)
	#else : print_debug("out of ammo")
