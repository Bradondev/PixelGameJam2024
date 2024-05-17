extends InterActable


@export var OpenedSpriteHighLight: Texture2D
@export var OpenedSprite: Texture2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("InterAct") and CanBeInteractedWIth:
		LoadInventory()
	
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
	sprite_2d.texture = OpenedSpriteHighLight
	OgSprite = OpenedSprite
	HighLightSprite = OpenedSpriteHighLight
	Opened = true
	Opentime =0
	OpenBar.visible = false
	OpeningInventory = false
	FlipInventory()
	
