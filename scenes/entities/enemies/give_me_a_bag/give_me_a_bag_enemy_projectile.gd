extends Area2D

var direction = Vector2.RIGHT
var speed = 50
var rotation_speed = 10


func _physics_process(delta):
	rotation += rotation_speed * delta
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
