extends CharacterBody2D

const POSITION_RADIUS = 50

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D

@export var limit = 0.5
@export var movement_speed : float = 50.0
@export var end_point : Marker2D

var start_position
var end_position

func _ready():
	start_position = global_position
	end_position = end_point.global_position


func change_direction():
	sprite.flip_h = !sprite.flip_h
	var temp_end = end_position
	end_position = start_position
	start_position = temp_end


func update_velocity():
	var move_direction = end_position - global_position
	if move_direction.length() < limit:
		change_direction()
	velocity = move_direction.normalized() * movement_speed


func _physics_process(delta):
	update_velocity()
	move_and_slide()



