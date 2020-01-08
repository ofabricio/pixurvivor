extends KinematicBody2D

class_name Survivor

var speedWalking = 20
var speedSprinting = speedWalking * 1.5
onready var cameraZoom: Vector2 = $Camera2D.zoom

var current_state = null

onready var states_map = {
	'idle': $States/Idle,
	'move': $States/Move,
}
onready var sprite = $Sprite
onready var asm : AnimationNodeStateMachinePlayback = $AnimationTree['parameters/playback']

func _ready():
	
	for state_node in $States.get_children():
		state_node.connect("finished", self, "change_state")
	
	change_state('idle')

func _physics_process(delta):
	current_state.update(delta)

func get_move_dir() -> Vector2:
	var movedir = Vector2()
	var R = Input.is_action_pressed('ui_right')
	var L = Input.is_action_pressed('ui_left')
	var D = Input.is_action_pressed('ui_down')
	var U = Input.is_action_pressed('ui_up')
	movedir.x = -int(L) + int(R)
	movedir.y = -int(U) + int(D)
	return movedir.normalized()

func change_state(next_state_name):
	print('survivor state: ', next_state_name)
	current_state = states_map[next_state_name]
	current_state.enter(self)
