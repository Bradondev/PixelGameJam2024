extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var options_menu: Control = $Options_Menu
@onready var load_screen: Control = $Load_Screen

func _ready() -> void:
	animation_player.play("guns")
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_option_button_pressed() -> void:
	options_menu.show()


func _on_start_button_pressed() -> void:
	load_screen.StartLoading()
func _on_button_pressed() -> void:
	options_menu.hide()
