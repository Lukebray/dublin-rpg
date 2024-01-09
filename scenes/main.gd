extends Node2D

@onready var health_container = $CanvasLayer/HealthContainer

var player_health_component
var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	player_health_component = get_tree().get_first_node_in_group("player").find_child("HealthComponent")
	health_container.set_max_health(player_health_component.max_health)
	health_container.update_health(player_health_component.current_health)
	player.health_changed.connect(_on_player_health_changed)


func _on_player_health_changed(current_health : int):
	health_container.update_health(current_health)
