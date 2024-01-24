extends Node
class_name DropComponent

@export var health_component : Node
@export var drop_item_scene : PackedScene


func _on_health_component_died():
		if drop_item_scene == null:
			return
	
		if not owner is Node2D:
			return
		
		var spawn_position = (owner as Node2D).global_position
		var drop_instance = drop_item_scene.instantiate() as Node2D
		
		var drops_layer = get_tree().get_first_node_in_group("drops_layer")
		drops_layer.add_child(drop_instance)
		drop_instance.global_position = spawn_position
