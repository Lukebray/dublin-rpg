extends AudioStreamPlayer2D

class_name RandomStreamPlayer2DComponent

@export var streams : Array[AudioStream]
@export var randomise_pitch = true
@export var min_pitch = 0.9
@export var max_pitch = 1.1


func play_random():
	if streams == null || streams.size() == 0:
		return
	
	stream = streams.pick_random()
	play()
