extends Control


func Switch(ToShow): ##  Commenting out the hide func as i want to see the UI buttons - Konscious
	var Ui = get_tree().get_nodes_in_group("stash")
	for i in Ui:
		i.hide()
	ToShow.show()

func _on_texture_button_pressed() -> void:
	Switch($Margin/ColorRect/MarginContainer/HBoxContainer/VBoxContainer/ColorRect/stash1)


func _on_texture_button_2_pressed() -> void:
	Switch($Margin/ColorRect/MarginContainer/HBoxContainer/VBoxContainer/ColorRect/stash2)


func _on_texture_button_3_pressed() -> void:
	Switch($Margin/ColorRect/MarginContainer/HBoxContainer/VBoxContainer/ColorRect/stash3)

func _on_texture_button_4_pressed() -> void:
	Switch($Margin/ColorRect/MarginContainer/HBoxContainer/VBoxContainer/ColorRect/stash4)


func _on_texture_button_5_pressed() -> void:
	Switch($Margin/ColorRect/MarginContainer/HBoxContainer/VBoxContainer/ColorRect/stash5)


func _on_texture_button_6_pressed() -> void:
	Switch($Margin/ColorRect/MarginContainer/HBoxContainer/VBoxContainer/ColorRect/stash6)


func _on_texture_button_7_pressed() -> void:
	Switch($Margin/ColorRect/MarginContainer/HBoxContainer/VBoxContainer/ColorRect/stash7)
