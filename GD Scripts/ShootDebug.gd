extends Button

@export var BulletToShoot: ItemType
@export var PlayerInventory:InventoryView
# Called when the node enters the scene tree for the first time.



func _on_pressed() -> void:
	UseBullet()
	
	
func UseBullet():
	
	var price : Dictionary = {BulletToShoot: 1}
	var items_to_check = {}
	var counts := {}

	print_debug(PlayerInventory.inventory.consume_items(price,false,items_to_check))
	
	return true
