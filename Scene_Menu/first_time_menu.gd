extends Control

signal tutorial_end 

func startScene():
	$Welcome.play()
	$MachineNoise.play()
	$Music.play()
	$Heli.play()
	$Timer.timeout.connect(loadIntroduction)
	$Timer.start()

func tutorial():
	$Welcome.stop()
	$MachineNoise.stop()
	$Heli.stop()
	$Intro.show()

func _on_confirm_pressed():
	$Music.stop()
	self.hide()
	emit_signal("tutorial_end")

func loadIntroduction():
	tutorial()
	$Intro.show()
	
