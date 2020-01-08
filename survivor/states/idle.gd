extends 'states.gd'

func update(_delta):
	survivor.asm.travel('idle')
	
	var moving = survivor.get_move_dir().length() > 0
	if moving:
		emit_signal('finished', 'move')
