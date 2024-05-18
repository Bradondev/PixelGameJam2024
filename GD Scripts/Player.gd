extends CharacterBody2D
class_name  Player


@export var MaxHealth :int = 100
@export var CurrentHealth: int = 100
@export var inventory: Control
@export var BasicItems : ItemInstantiator
@export var speed :int = 10000 # speed in pixels/sec
@export var PlayerInventory:InventoryView
@export var ui: CanvasLayer 
@onready var gun: Node2D = $Gun
@onready var gun_2: Node2D = $Gun2

var CurrentGunNode : GunNode


@onready var composite_sprite: Node2D = $CompositeSprite

@onready var mid_bar: TextureProgressBar = $UI/BotMargin/Hbox/Player/Resources/MidBar
@onready var equipment: InventoryView = $UI/Inventory/Margin/EquipmentAndInventory/EquipmentVbox/Equip
@onready var Name: RichTextLabel = $UI/Inventory/Margin/EquipmentAndInventory/EquipmentVbox/DescriptionbackGround/name
@onready var description: RichTextLabel = $UI/Inventory/Margin/EquipmentAndInventory/EquipmentVbox/DescriptionbackGround/Description

func  _ready() -> void: 
	CurrentGunNode = gun
	UpdataProgress()

	
	
func _physics_process(delta):
	var Action = "walk"
	if CurrentGunNode.global_rotation_degrees + 90 <= 0 or  CurrentGunNode.global_rotation_degrees + 90 >= 180 :
		composite_sprite.scale.x = -1
	else:
		composite_sprite.scale.x = 1
	
	if !CurrentGunNode.isShooting:
		var direction = Input.get_vector("Left", "Right", "Up", "Down")
		velocity = direction * speed * delta
		move_and_slide()
		SetAnim(Action)
	

		
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


func EditDescriptionAField(item_view: ItemStackView):
	description.text = "[center]" +item_view.stack.item_type.description
	Name.text = "[center]" + item_view.stack.item_type.name


func CheckForAngle():
	var CurrentRoation = CurrentGunNode.global_rotation_degrees
	if CurrentRoation >=-90 and CurrentRoation <= -67.5 or CurrentRoation >= -112.5 and CurrentRoation <= -90:
		
		return "up"
	elif CurrentRoation >-67.5 and CurrentRoation < -22.5 or CurrentRoation >= -157.5 and CurrentRoation <= -112.5:
		return "45up"
	elif CurrentRoation >=-22.5 and CurrentRoation <= 22.5 or abs(CurrentRoation )>= 157.5 :
		return "R"
	elif CurrentRoation >=22.5 and CurrentRoation <= 67.5 or CurrentRoation <= 157.5 and CurrentRoation >= 112.5:
		return "45down"

	elif CurrentRoation >67.5 and CurrentRoation <=90 or CurrentRoation <= 112.5 and CurrentRoation >=90:
		return "down"
	#67.5
	
func SetAnim(NameOfAction):
	if CurrentGunNode.CurrentGun:
		
		composite_sprite.gun.visible = true
		var AnimationName = NameOfAction+"_" + CheckForAngle() +"_"+ CurrentGunNode.CurrentGun.GunType
		var time =	composite_sprite.sprite_player.current_animation_position
		composite_sprite.AnimPlayer(AnimationName,.001)
		#if NameOfAction == "shoot":
			#composite_sprite.sprite_player.get_animation(composite_sprite.sprite_player.current_animation).loop_mode = 0
		composite_sprite.sprite_player.seek(time, true)
	else: 
		composite_sprite.gun.visible = false
		var AnimationName = "walk"+"_" + CheckForAngle() +"_"+"pistol"
		var time =	composite_sprite.sprite_player.current_animation_position
		composite_sprite.AnimPlayer(AnimationName,.001)
		composite_sprite.sprite_player.seek(time, true)



