extends State
class_name ShootState

@export var projectile_node : PackedScene

@onready var timer = $Timer

var audio_playing : bool

func transition():
	var owner_health_componment = owner.get_node("HealthComponent")
	
	if not player_detection_ray.is_colliding():
		if owner_health_componment.get_health_percent() > 0.5:
				get_parent().change_state("Follow")
		else:
			get_parent().change_state("Dash")


func enter():
	super.enter()
	timer.start()
	
	if get_parent().previous_state.name == "Idle":
		if audio_playing:
			return
	
		audio_playing = true
		owner.random_stream_player_2d_component.play_random()
		await owner.random_stream_player_2d_component.finished
		audio_playing = false


func exit():
	super.exit()
	timer.stop()


func _on_timer_timeout():
	shoot()


func shoot():
	var projectile = projectile_node.instantiate()
	
	projectile.position = global_position
	projectile.direction = (player.global_position - global_position).normalized()
	
	get_tree().current_scene.call_deferred("add_child", projectile)
