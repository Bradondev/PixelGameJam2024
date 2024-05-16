extends CharacterBody2D
class_name  Player


@export var MaxHealth :int = 100
@export var CurrentHealth: int = 100
@export var inventory: Control

@export var speed :int = 10000 # speed in pixels/sec
@export var PlayerInventory:InventoryView
@export var ui: CanvasLayer 
@onready var gun: Node2D = $Gun
@onready var gun_2: Node2D = $Gun2

@onready var mid_bar: TextureProgressBar = $UI/BotMargin/Hbox/Player/Resources/MidBar
@onready var equipment: InventoryView = $UI/Inventory/Equip


func  _ready() -> void: 
	UpdataProgress()
	pass
func _physics_process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed * delta
	move_and_slide()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("menu_inventory"):
		FlipInventory()
	

func FlipInventory():
	if !inventory.visible:
		inventory.show()
		gun.process_mode = Node.PROCESS_MODE_DISABLED
	
	else:
		inventory.hide()
		gun.process_mode = Node.PROCESS_MODE_INHERIT
		

func UpdateSpirt():
	pass

func TakeDamage(Amount:int):
	CurrentHealth -= Amount
	if CurrentHealth <=0:
		CurrentHealth = 0
	UpdataProgress()
	
func UpdataProgress():
	mid_bar.value = CurrentHealth
	mid_bar.max_value = MaxHealth







func _on_equip_item_stack_added(item_stack: ItemStack) -> void:
	if item_stack.position_in_inventory == Vector2(0,0):
		gun.CurrentGun =item_stack.item_type.custom_data
		gun.UpdateAmmoText()
		print_debug("weapon 1")
	elif item_stack.position_in_inventory == Vector2(1,0):
		gun_2.CurrentGun =item_stack.item_type.custom_data
		gun_2.UpdateAmmoText()
		
		print_debug("weapon 2")
	elif item_stack.position_in_inventory == Vector2(2,0):
		print_debug("Throwable")
	elif item_stack.position_in_inventory == Vector2(3,0):
		print_debug("Helm")
	elif item_stack.position_in_inventory == Vector2(4,0):
		print_debug("Chest")
	elif item_stack.position_in_inventory == Vector2(5,0):
		print_debug("plants")
	elif item_stack.position_in_inventory == Vector2(6,0):
		print_debug("feet")


func _on_equip_item_stack_removed(item_stack: ItemStack) -> void:
	if item_stack.position_in_inventory == Vector2(0,0):
		gun.CurrentGun = null
		gun.UpdateAmmoText()
		print_debug("weapon 1")
	elif item_stack.position_in_inventory == Vector2(1,0):
		
		gun_2.CurrentGun = null
		gun_2.UpdateAmmoText()
		print_debug("weapon 2")
	elif item_stack.position_in_inventory == Vector2(2,0):
		print_debug("Throwable")
	elif item_stack.position_in_inventory == Vector2(3,0):
		print_debug("Helm")
	elif item_stack.position_in_inventory == Vector2(4,0):
		print_debug("Chest")
	elif item_stack.position_in_inventory == Vector2(5,0):
		print_debug("plants")
	elif item_stack.position_in_inventory == Vector2(6,0):
		print_debug("feet")
