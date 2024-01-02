extends CharacterBody2D

@export var movement_speed = 50

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var previous_movement_direction : Vector2

func _physics_process(_delta):
	handle_input()
	move_and_slide()
	update_movement_animation()

func update_movement_animation():
	# IDLE
	if velocity == Vector2.ZERO:
		if previous_movement_direction == Vector2.UP:
			animation_player.play("idle_back")
		elif previous_movement_direction == Vector2.DOWN:
			animation_player.play("idle_front")
		elif previous_movement_direction == Vector2.RIGHT:
			if sprite_2d.flip_h == true:
				sprite_2d.flip_h = false
			animation_player.play("idle_side")
		elif previous_movement_direction == Vector2.LEFT:
			if sprite_2d.flip_h == false:
				sprite_2d.flip_h = true
			animation_player.play("idle_side")
		else:
			animation_player.play("idle_front")
	
	# MOVING
	if velocity.x < 0:
		if sprite_2d.flip_h == false:
			sprite_2d.flip_h = true
		animation_player.play("walk_right") # reverse this since it's walking left
	elif velocity.x > 0:
		if sprite_2d.flip_h == true:
			sprite_2d.flip_h = false
		animation_player.play("walk_right")
	elif velocity.y > 0:
		animation_player.play("walk_down")
	elif velocity.y < 0:
		animation_player.play("walk_up")


func handle_input():
	var move_direction = Input.get_vector("left", "right", "up", "down")
	if move_direction:
		previous_movement_direction = move_direction
	velocity = move_direction * movement_speed
