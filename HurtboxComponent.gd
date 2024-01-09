extends Area2D
class_name HurtboxComponent

signal hit

@export var health_component : Node


func _on_area_entered(area): #when the hurtbox collides with a hitbox do this
	if not area is HitboxComponent:
		return
		
	if health_component == null:
		return 
	
	var hitbox_component = area as HitboxComponent
	health_component.damage(hitbox_component.damage)
