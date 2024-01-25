extends CharacterBody2D

@export var movement_speed : float = 30
@export var acceleration : float = 50

@onready var navigation_agent = $NavigationAgent2D


var movement_target_position : Vector2 = Vector2(0, 1)
var path_length : float = 100

var current_state = MOVE
var direction = Vector2.RIGHT
var start_pos
var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	MOVE
}

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	#navigation_agent.debug_enabled = true
	
	randomize()
	start_pos = position
	call_deferred("actor_setup")


func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	
	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)


func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target


func _process(_delta):
	if velocity == Vector2.DOWN:
		print("DOWN")
	if current_state == 0:
		$AnimatedSprite2D.play("idle")
	elif current_state == 1 && !is_chatting:
		if direction.x == -1:
			$AnimatedSprite2D.play("walk_west")
		if direction.x == 1:
			$AnimatedSprite2D.play("walk_east")
		if direction.y == -1:
			$AnimatedSprite2D.play("walk_north")
		if direction.y == 1:
			$AnimatedSprite2D.play("walk_south")

	if Input.is_action_just_pressed("action") && player_in_chat_zone == true:
		is_roaming = false
		is_chatting = true
		
		if !$AudioStreamPlayer2D.playing:
			$AudioStreamPlayer2D.play()

		$AnimatedSprite2D.play("idle")


func _physics_process(_delta):	
	if is_roaming:
		match current_state:
			IDLE:
				pass
#			NEW_DIR:
#				direction = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move()
				move_and_slide()
	
	

func choose(array):
	array.shuffle()
	return array.front()


func move():
	if !is_chatting:
		if navigation_agent.is_navigation_finished():
			direction  = get_random_direction()
			var movement_target = global_position * direction * path_length
			set_movement_target(movement_target)
			return 
		
		var current_agent_position : Vector2 = global_position
		var next_path_position : Vector2 = navigation_agent.get_next_path_position()

		velocity = current_agent_position.direction_to(next_path_position).normalized() * movement_speed


func get_random_direction():
	return choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])

func _on_chat_detection_body_entered(body):
	print("body = ", body.name)
	if body.is_in_group("player"):
		player_in_chat_zone = true


func _on_chat_detection_body_exited(body):
	if body.is_in_group("player"):
		player_in_chat_zone = false
		is_roaming = true
		is_chatting = false


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1.0, 1.5])
	current_state = choose([IDLE, MOVE])
	#current_state = choose([MOVE])
