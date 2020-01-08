extends "states.gd"

func update(_delta):
	
	var velocity = survivor.get_move_dir()
	var should_move = velocity.length() > 0
	var sprinting = Input.is_action_pressed('sprint')

	var should_walk = should_move && !sprinting
	var should_sprint = should_move && sprinting

	if should_walk:
		should_move(velocity * survivor.speedWalking, 'walk')
	elif should_sprint:
		should_move(velocity * survivor.speedSprinting, 'sprint')
	else:
		emit_signal('finished', 'idle')


func should_move(dir, anim):
	# Try to move.
	var velocity = survivor.move_and_slide(dir)

	# Play a move animation or idle if not moving due to collision.
	var moving = velocity.length() > 0
	if !moving:
		anim = 'idle'
	survivor.asm.travel(anim)

	# Flip the survivor's sprite if required.
	survivor.sprite.flip_h = velocity.x < 0

