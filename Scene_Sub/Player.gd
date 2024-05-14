extends CharacterBody2D
class_name  Player


@export var MaxHealth :int

@export var inventory: Control

@export var speed :int = 10000 # speed in pixels/sec
@export var PlayerInventory:InventoryView
@export var ui: CanvasLayer 
@onready var gun: Node2D = $Gun


func  _ready() -> void: 
	pass
func _physics_process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed * delta
	move_and_slide()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_inventory"):
		FlipInventory()

func FlipInventory():
	if !inventory.visible:inventory.show()
	else: inventory.hide()


func UpdateSpirt():
	pass
