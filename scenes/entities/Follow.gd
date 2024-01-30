extends MyState
class_name FollowState

var audio_playing : bool

func transition():
	if player_detection_ray.is_colliding():
		get_parent().change_state("Shoot")


func enter():
	super.enter()
	owner.set_physics_process(true)
	if audio_playing:
		return
	
	audio_playing = true
	owner.random_stream_player_2d_component.play_random()
	await owner.random_stream_player_2d_component.finished
	audio_playing = false


func exit():
	super.exit()
	owner.set_physics_process(false)
