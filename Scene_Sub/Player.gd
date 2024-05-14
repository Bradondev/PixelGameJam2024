extends CharacterBody2D
class_name  Player


@export var MaxHealth :int

@export var inventory: Control

@export var speed :int = 400  # speed in pixels/sec
@export var PlayerInventory:InventoryView
@export var ui: CanvasLayer 


func  _ready() -> void: 
	pass
func _physics_process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide()
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_inventory"):
		FlipInventory()



func FlipInventory():
	if !inventory.visible:inventory.show()
	else: inventory.hide()
