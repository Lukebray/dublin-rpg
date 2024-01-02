extends CharacterBody2D

@onready var random_stream_player_2d_component = $RandomStreamPlayer2DComponent as RandomStreamPlayer2DComponent

@export var movement_speed : float = 50.0
@export var acceleration : float = 5

var player_detected = false
var audio_playing : bool = false

func _process(_delta):
	if player_detected:
		accelerate_to_player()
	move_and_slide()


func accelerate_in_direction(direction : Vector2):
	var desired_velocity = direction * movement_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time())) 


func accelerate_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var direction = (player.global_position - global_position).normalized()
	accelerate_in_direction(direction)


func _on_hitbox_area_entered(area):
	if (area.name == "StickAbility"):
		print("enemy hit -> ", area.name)


func _on_player_detection_zone_area_entered(area):
	player_detected = true
	if audio_playing:
		return
	
	audio_playing = true
	random_stream_player_2d_component.play_random()
	await random_stream_player_2d_component.finished
	audio_playing = false
	
