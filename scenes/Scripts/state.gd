extends Node2D
class_name MyState


@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_detection_ray = owner.find_child("PlayerDetectionRay")
@onready var debug_text = owner.find_child("Debug")

func _ready():
	set_physics_process(false)


func enter():
	set_physics_process(true) #will enable the physics process


func exit():
	set_physics_process(false)


func transition():
	pass


func _physics_process(_delta):
	transition()
	debug_text.text = name
