extends Area2D
class_name HurtboxComponent

signal hit

@onready var timer = $Timer

@export var health_component : Node

var enemy_velocity : Vector2 = Vector2.ZERO
var invulnerable : bool = false

func _on_area_entered(area): #when the hurtbox collides with a hitbox do this
	if not area is HitboxComponent:
		return
		
	if health_component == null:
		return
		
	if !invulnerable:
		timer.start()
		invulnerable = true
		if area.owner is CharacterBody2D:
			enemy_velocity = area.owner.velocity
			
		hit.emit(enemy_velocity, area)
		var hitbox_component = area as HitboxComponent
		health_component.damage(hitbox_component.damage)


func _on_timer_timeout():
	invulnerable = false
