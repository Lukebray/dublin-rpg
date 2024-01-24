extends CharacterBody2D

@export var movement_speed : float = 30
@export var acceleration : float = 50

var current_state = IDLE
var direction = Vector2.RIGHT
var start_pos
var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	player = get_tree().get_first_node_in_group("player")
	randomize()
	start_pos = position


func _process(delta):
	if current_state == 0 || current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 && !is_chatting:
		if direction.x == -1:
			$AnimatedSprite2D.play("walk_west")
		if direction.x == 1:
			$AnimatedSprite2D.play("walk_east")
		if direction.y == -1:
			$AnimatedSprite2D.play("walk_north")
		if direction.y == 1:
			$AnimatedSprite2D.play("walk_south")
	
	if Input.is_action_just_pressed("action") && player_in_chat_zone == true:
		print("chatting with NPC")
		is_roaming = false
		is_chatting = true
		$AnimatedSprite2D.play("idle")


func _physics_process(delta):
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				direction = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move()
				move_and_slide()
	
	

func choose(array):
	array.shuffle()
	return array.front()


func move():
	if !is_chatting:
		var desired_velocity = direction * movement_speed
		velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time())) 


func _on_chat_detection_body_entered(body):
	print("body = ", body.name)
	if body.is_in_group("player"):
		player_in_chat_zone = true


func _on_chat_detection_body_exited(body):
	if body.is_in_group("player"):
		player_in_chat_zone = false


func _on_timer_timeout():
	$Timer.wait_time = choose([0.5, 1.0, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])


func _on_chat_detection_area_entered(area):
	print("area = ", area.name)
