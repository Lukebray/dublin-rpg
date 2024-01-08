extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D

@export var limit = 0.5
@export var movement_speed : float = 50.0
@export var max_health : int = 1
var current_health: = max_health: #setter function for health. This function will run when there is a change in the health variable!
	set(value):
		if (value != 0):
			current_health = value
			#health_bar.value = value
		else: 
			queue_free()

var start_position
var end_position


func _ready():
	start_position = position
	end_position = start_position + Vector2(3*16, 0)

func change_direction():
	sprite.flip_h = !sprite.flip_h
	var temp_end = end_position
	end_position = start_position
	start_position = temp_end


func update_velocity():
	var move_direction = end_position - position
	if move_direction.length() < limit:
		change_direction()
	velocity = move_direction.normalized() * movement_speed


func _physics_process(delta):
	update_velocity()
	move_and_slide()


func _on_hitbox_area_entered(area):
		if (area.name == "StickAbility"):
			current_health -=1
