extends CharacterBody2D

@onready var random_stream_player_2d_component = $RandomStreamPlayer2DComponent as RandomStreamPlayer2DComponent
@onready var player_detection_ray = $PlayerDetectionRay
@onready var player = get_tree().get_first_node_in_group("player")
@onready var health_bar = $HealthBar

@export var max_health : int = 4
var current_health: = max_health: #setter function for health. This function will run when there is a change in the health variable!
	set(value):
		if (value != 0):
			current_health = value
			health_bar.value = value
		else: 
			queue_free()

@export var movement_speed : float = 50.0
@export var acceleration : float = 5

var direction = Vector2.RIGHT
var player_detected = false
var audio_playing : bool = false


func _ready():
	set_physics_process(false)


func _process(_delta):
	direction = (player.global_position - global_position).normalized()
	player_detection_ray.target_position = direction * 40


func _physics_process(delta):
	var desired_velocity = direction * movement_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time())) 
	move_and_slide()


func _on_hitbox_area_entered(area):
	if (area.name == "StickAbility"):
		current_health -=1
