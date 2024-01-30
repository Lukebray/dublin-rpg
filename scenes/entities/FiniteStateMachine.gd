extends Node2D
class_name FiniteStateMachine

var current_state : MyState
var previous_state : MyState


func _ready():
	current_state = get_child(0) as MyState #just start at the first state which is Idle
	previous_state = current_state
	current_state.enter() #enable the physics process for the chosen state


func change_state(state):
	current_state = find_child(state) as MyState
	current_state.enter()
	
	previous_state.exit()
	previous_state = current_state
