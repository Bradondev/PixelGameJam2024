extends Control

@onready var is_sound_on : bool = true

func toggleSounds(is_sound_on):
	$Welcome.autoplay = is_sound_on
	$MachineNoise.autoplay = is_sound_on
	$Music.autoplay = is_sound_on
	$Heli.autoplay = is_sound_on

func tutorial():
	$Welcome.stop()
	$MachineNoise.stop()
	$Heli.stop()
	$Intro.show()

func _ready():
	toggleSounds(is_sound_on)
	$Timer.timeout.connect(loadIntroduction)

func _on_confirm_pressed():
	$Load_Screen.StartLoading()

func loadIntroduction():
	tutorial()
	$Intro.show()
