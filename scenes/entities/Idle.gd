extends State
class_name IdleState


func transition():
	if player_detection_ray.is_colliding() && player_detection_ray.get_collider().owner.name == "Player":
		get_parent().change_state("Shoot") #get the finite state machine and change the state to shoot
