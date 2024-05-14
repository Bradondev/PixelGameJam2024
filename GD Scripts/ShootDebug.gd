extends Button

@export var mag: ItemType
@export var BulletToShoot: ItemType
@export var PlayerInventory:InventoryView
# Called when the node enters the scene tree for the first time.



func _on_pressed() -> void:
	#UseBullet()
	UseBulletInMag()
	
func UseBullet():
	
	var price : Dictionary = {BulletToShoot: 1}
	var items_to_check = {}
	var counts := {}

	print_debug(PlayerInventory.inventory.consume_items(price,false,items_to_check))
	
	return true
func UseBulletInMag():
	var price : Dictionary = {mag: 1}
	var items_to_check = {}
	var counts := {}
	var Mag = PlayerInventory.inventory.consume_items(price,true,items_to_check)
	Mag[0].extra_properties.stats.Amount =1
	print_debug(Mag[0].extra_properties.stats.Amount)
