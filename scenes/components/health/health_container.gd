extends HBoxContainer

@export var heart_gui_class = preload("res://scenes/components/health/health_heart.tscn")


func set_max_health(max : int):
	for i in range(max):
		var heart = heart_gui_class.instantiate()
		add_child(heart)


func update_health(current_health : int):
	var health_hearts = get_children()
	
	for i in range(current_health):
		health_hearts[i].update(true)
	
	for i in range(current_health, health_hearts.size()):
		health_hearts[i].update(false)
