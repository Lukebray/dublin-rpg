extends Panel

@onready var sprite = $Sprite2D
@onready var full_heart_sprite = preload("res://art/hearts/heart.png")
@onready var empty_heart_sprite = preload("res://art/hearts/empty_heart.png")


func update(whole : bool):
	if whole:
		sprite.texture = full_heart_sprite
	else:
		sprite.texture = empty_heart_sprite
