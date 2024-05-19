extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var options_menu: Control = $Options_Menu
@onready var load_screen: Control = $Load_Screen


var master_Bus = AudioServer.get_bus_index("Master")
var music_Bus = AudioServer.get_bus_index("Music")
var sfx_Bus = AudioServer.get_bus_index("SFX")

func sounds():
	$MenuSound.play()

func _ready() -> void:
	animation_player.play("guns")
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_option_button_pressed() -> void:
	options_menu.show()

func _on_start_button_pressed() -> void:
	load_screen.StartLoading()
	animation_player.stop()
	var timer = Timer.new()
	timer.timeout.connect(fade)
	add_child(timer)
	timer.start(0.5)

func _on_button_pressed() -> void:
	options_menu.hide()
	animation_player.stop()

#// Sounds for mouse hovering buttons 
func _on_start_button_mouse_entered() -> void:
	sounds()
func _on_option_button_mouse_entered():
	sounds()
func _on_quit_button_mouse_entered():
	sounds()

func fade():
	$Music.volume_db -= 2

func SetBusVolume(busName, volume):

	AudioServer.set_bus_volume_db(busName, volume)
	if volume == -30:
		SetBusMute(busName, true)
	else:
		SetBusMute(busName, false)

func SetBusMute(busName, bIsMuted):
	AudioServer.set_bus_mute(busName, bIsMuted)

func _on_spin_box_value_changed(value: float) -> void:
	SetBusVolume(master_Bus, value)
