extends MyState
class_name DashState

@onready var timer = $Timer

func transition():
	if player_detection_ray.is_colliding():
		get_parent().change_state("Shoot")

func enter():
	super.enter()
	timer.start()


func exit():
	super.exit()
	timer.stop()


func dash():
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position", player.position, 0.75)

func _on_timer_timeout():
	dash()
