extends Button

@export var BulletToShoot: ItemType
@export var PlayerInventory:InventoryView
# Called when the node enters the scene tree for the first time.



func _on_pressed() -> void:
	UseBullet()
	
	
func UseBullet():
	var price : Dictionary = {BulletToShoot.resource_path: 1}
	var items_to_check = {}
	var counts := {}
	for k in price:
		if !counts.has(k) || counts[k] < price[k]:
			return false

		if k is ItemPattern:
			k.collect_item_dict(items_to_check)

		else:
			items_to_check[k] = true

	PlayerInventory.inventory.consume_items(price,false,items_to_check)
	return true
