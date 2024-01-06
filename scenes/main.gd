extends Node2D

@onready var health_container = $CanvasLayer/HealthContainer

var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	health_container.set_max_health(player.max_health)
	health_container.update_health(player.current_health)
	player.health_changed.connect(_on_player_health_changed)


func _on_player_health_changed(current_health : int):
	health_container.update_health(current_health)
