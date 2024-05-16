extends EffectResource
class_name ExplosionEffect

@export var EffectScene:PackedScene

func trigger_effect(entity) -> void:
	var killEffect = EffectScene.instantiate()
	entity.get_tree().root.call_deferred("add_child", killEffect)
