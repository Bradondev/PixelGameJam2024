extends Node2D
class_name  InterActable
@export var HighLightArea :Area2D
@export var InterArea :Area2D 
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var HighLightSprite : Texture2D
@export var OgSprite: Texture2D
@onready var inventory: InventoryView = $CanvasLayer/MarginContainer
@onready var label: Label = $Label
@export var Opentime:float
@onready var OpenBar: TextureProgressBar = $BotBar

@export var HasInventory : bool = false
@export var InveentroyContent : ItemInstantiator
var CanBeInteractedWIth: bool = false
var tween  : Tween

var OpeningInventory : bool = false
var Opened : bool = false
func _ready() -> void:
	if InveentroyContent:
		inventory.contents = InveentroyContent
	pass

func _on_inter_act_area_body_entered(body: Node2D) -> void:
	if !body.is_in_group("Player") : return
	print_debug(body)
	CanBeInteractedWIth = true
	sprite_2d.texture = HighLightSprite
	label.visible = true
func _on_inter_act_area_body_exited(body: Node2D) -> void:
	if !body.is_in_group("Player") : return
	CanBeInteractedWIth = false
	inventory.hide()
	sprite_2d.texture = OgSprite
	label.visible = false
	Opened = false
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.inventory.hide()
	player.gun.process_mode = Node.PROCESS_MODE_INHERIT
	if tween:
		KillTween()
func _on_highlight_area_body_exited(body: Node2D) -> void:
	CanBeInteractedWIth = true
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("InterAct") and CanBeInteractedWIth:
		if HasInventory:
			LoadInventory()
			#FlipInventory()
		
func FlipInventory():
	var player = get_tree().get_nodes_in_group("Player")[0]
	if !inventory.visible:
		inventory.show()
		player.inventory.show()
		player.gun.process_mode = Node.PROCESS_MODE_DISABLED
	
	else:
		inventory.hide()
		player.inventory.hide()
		player.gun.process_mode = Node.PROCESS_MODE_INHERIT
func LoadInventory():
	if Opened:
		FlipInventory() 
		Opened = false
		return 
	if OpeningInventory:
		KillTween()
		return
	OpenBar.value = 0
	OpenBar.visible = true
	OpeningInventory = true
	tween  = create_tween()
	tween.tween_property(OpenBar, "value", 100,Opentime)
	await  tween.finished
	Opened = true
	OpenBar.visible = false
	OpeningInventory = false
	FlipInventory()
	
func KillTween():
	tween.kill()
	OpeningInventory = false
	OpenBar.value = 0
	OpenBar.visible = false
