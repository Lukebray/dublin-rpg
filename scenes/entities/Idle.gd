extends State
class_name IdleState


func transition():
	if player_detection_ray.is_colliding():
		get_parent().change_state("Shoot") #get the finite state machine and change the state to shoot
