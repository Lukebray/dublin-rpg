extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health : float = 0
var current_health

func _ready():
	current_health = max_health


func damage(damage_amount : float):
	current_health = max(current_health - damage_amount, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()


func get_health_percent():
	if max_health <= 0:
		return 0
	
	return min(current_health / max_health, 1)


func check_death():
	if owner.name == "Player" && current_health == 0:
		print("PLAYER DIED :(")
		current_health = max_health + 1
		return
	
	if current_health == 0:
		print("ENEMY KILLED!")
		died.emit()
		owner.queue_free() # get rid of entity this component is on