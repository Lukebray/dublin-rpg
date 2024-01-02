extends CharacterBody2D

@export var movement_speed : float = 50

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var weapon = $Weapon as Node2D

var previous_movement_direction : Vector2
var is_attacking : bool

func _ready():
	is_attacking = false
	previous_movement_direction = Vector2.DOWN
	weapon.visible = false


func _physics_process(_delta):
	handle_input()
	move_and_slide()
	handle_collision()
	update_animation()


func handle_input():
	var move_direction = Input.get_vector("left", "right", "up", "down")
	if move_direction:
		previous_movement_direction = move_direction
	velocity = move_direction * movement_speed
	
	if Input.is_action_just_pressed("attack"):
		update_attack_animation()


func handle_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()


func update_animation():
	if is_attacking:
		return
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
	
	# MOVING
	if velocity.x < 0: # moving right
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


func update_attack_animation():
	is_attacking = true
	weapon.visible = true
	if velocity == Vector2.ZERO:
		if previous_movement_direction == Vector2.UP:
			animation_player.play("attack_up")
		elif previous_movement_direction == Vector2.DOWN:
			animation_player.play("attack_down")
		elif previous_movement_direction == Vector2.RIGHT:
			animation_player.play("attack_right")
		elif previous_movement_direction == Vector2.LEFT:
			animation_player.play("attack_left")

	if velocity.y < 0: # moving up
		animation_player.play("attack_up")
	elif velocity.y > 0: # moving down
		animation_player.play("attack_down")
	elif velocity.x > 0: # moving right
		animation_player.play("attack_right")
	elif velocity.x < 0: # moving left
		animation_player.play("attack_left")
		
	await animation_player.animation_finished
	is_attacking = false
	weapon.visible = false


func _on_hurtbox_area_entered(area):
	if area.name == "Hitbox":
		print("Damage player")
