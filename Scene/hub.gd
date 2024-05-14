extends Control


@onready var mission: Control = $Mission
@onready var stash: Control = $Stash
@onready var shop: Control = $shop
@onready var buttons: HBoxContainer = $Buttons



func Switch(ToShow):
	var Ui = get_tree().get_nodes_in_group("Ui")
	for i in Ui:
		i.hide()
	ToShow.show()

func _on_missions_pressed() -> void:
	Switch(mission)


func _on_stash_pressed() -> void:
	Switch(stash)


func _on_shop_pressed() -> void:
	Switch(shop)



func _on_back_pressed() -> void:
	Switch(buttons)
