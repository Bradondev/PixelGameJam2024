extends Control

@export var MissionList :Array[PackedScene]

@onready var mission: Control = $Mission
@onready var stash: Control = $Stash
@onready var shop: Control = $shop
@onready var buttons: HBoxContainer = $Margin/Vbox/Center/HubTubs
@onready var sounds : AudioStreamPlayer = $MenuSound
@onready var npcTalk : RichTextLabel = $Margin/Vbox/ColorRect/MarginContainer/RichTextLabel

#// LOADING_SCREEN mechanism
@onready var mission1 : Control = $Load_Screen1
@onready var mission2 : Control = $Load_Screen2
@onready var mission3 : Control = $Load_Screen3
@onready var tutorial : Control = $Load_Screen4

var destination = null



func Switch(ToShow): ##  Commenting out the hide func as i want to see the UI buttons - Konscious
	var Ui = get_tree().get_nodes_in_group("Ui")
	for i in Ui:
		i.hide()
	ToShow.show()

func SoundEffects():
	sounds.play()

func fadeSound():
	var timer = Timer.new()
	timer.timeout.connect(fade)
	add_child(timer)
	timer.start(0.2)

func fade():
	$Music.volume_db -= 2

func ColorSwap(color_string : String):
	$ColorRect.color = Color(color_string)

func MissionStart(level_select):
	fadeSound()
	$Launch.play()
	destination = level_select

func _ready():
	ColorSwap("282828")

func _on_missions_pressed() -> void:
	Switch(mission)

func _on_stash_pressed() -> void:
	Switch(stash)

func _on_shop_pressed() -> void:
	Switch(shop)

func _on_back_pressed() -> void:
	Switch(buttons)

'''
ALL THE GUI SOUNDS AND COLORS DONE HERE
'''
#// MOUSE ENTERED // SWAP COLOR, MAKE SOUND EFFECT, CHANGE DIALOGUE FLAVOR TEXT AT BOTTOM
func _on_shop_mouse_entered(): 
	SoundEffects()
	ColorSwap("297653")
	npcTalk.text = "Ay, merc! I know you want to get decked out in some new irons. C'mon, I know you got a few Aqua to shill out!"
func _on_stash_mouse_entered():
	SoundEffects()
	ColorSwap("b06745")
	npcTalk.text = "Hey there partner. Don't you worry, I've got all your sweet gear locked up nice and tight."
func _on_missions_mouse_entered():
	SoundEffects()
	ColorSwap("317791")
	npcTalk.text = "Aw yeah! Time to go scavenge! Time to kick butt and get paid!"
func _on_tutorial_mouse_entered():
	SoundEffects()
	ColorSwap("000000")
	npcTalk.text = "First time here? time to learn WHY you're here!"


#// MOUSE EXITED // SET BACK TO DEFAULT COLOR AND DEFAULT FLAVOR TEXT
func _on_shop_mouse_exited():
	ColorSwap("282828")
	npcTalk.text = "What's your business here?!"
func _on_stash_mouse_exited():
	ColorSwap("282828")
	npcTalk.text = "What's your business here?!"
func _on_missions_mouse_exited():
	ColorSwap("282828")
	npcTalk.text = "What's your business here?!"
func _on_tutorial_mouse_exited():
	ColorSwap("282828")
	npcTalk.text = "What's your business here?!"

'''
MISSION LAUNCH LOGIC
'''
#// MISSION 1
func _on_depart_button_1_mouse_entered():
	SoundEffects()
func _on_depart_button_1_pressed():
	MissionStart(1)
func _on_complete_button_1_mouse_entered():
	SoundEffects()
func _on_complete_button_1_pressed():
	print("############ Mission 1 completion not coded yet!")
#// MISSION 2
func _on_depart_button_2_mouse_entered():
	SoundEffects()
func _on_depart_button_2_pressed():
	MissionStart(2)
func _on_complete_button_2_mouse_entered():
	SoundEffects()
func _on_complete_button_2_pressed():
	print("############ Mission 2 completion not coded yet!")
#// MISSION 3
func _on_depart_button_3_mouse_entered():
	SoundEffects()
func _on_depart_button_3_pressed():
	MissionStart(3)
func _on_complete_button_3_mouse_entered():
	SoundEffects()
func _on_complete_button_3_pressed():
	print("############ Mission 3 completion not coded yet!")

'''
LAUNCH TUTORIAL
'''
func _on_tutorial_pressed():
	$FirstTime_Menu.startScene()
	$Music.stop()
	$FirstTime_Menu.show()
'''
RESUME HUB MUSIC AT END OF TUTORIAL
'''
func _on_first_time_menu_tutorial_end():
	$Music.play()

#// SWITCH STATEMENT TO LOAD UP LOADING SCREEN WITH APPROPRIATE MAP DESTINATION
func _on_launch_finished():
	print_debug("done")
	match destination:
		1: mission1.StartLoading()
		2: mission2.StartLoading()
		3: mission3.StartLoading()




func _on_player_item_stack_selected(item_view: ItemStackView) -> void:
	$Stash/Inventory/Margin/EquipmentAndInventory/EquipmentVbox/DescriptionbackGround/name.text = "[center]" +item_view.stack.item_type.description
	$Stash/Inventory/Margin/EquipmentAndInventory/EquipmentVbox/DescriptionbackGround/Description.text= "[center]" + item_view.stack.item_type.name






