extends Sprite2D

@onready var pivot = $Marker2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pivot.look_at(get_global_mouse_position())
	
	if get_global_mouse_position().x < 0:
		$".".flip_h = true
		$Marker2D/Sprite2D2.flip_v = true
		$Marker2D/Sprite2D2.position = Vector2(5, 3)
	else: 
		$".".flip_h = false
		$Marker2D/Sprite2D2.flip_v = false
		$Marker2D/Sprite2D2.position = Vector2(5, -3)
