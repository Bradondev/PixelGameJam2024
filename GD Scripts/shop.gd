extends Control


@export var ShopInven: InventoryView 
@export var shop_manager_2: InventoryVendor 

func _on_refresh_pressed() -> void:
	refreshShop()




func  refreshShop():
	shop_manager_2.refill_stock()
