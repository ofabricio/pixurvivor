"""
Base interface for all states.
"""
extends Node

signal finished(next_state_name)

var survivor: Survivor = null

func enter(host: Survivor):
	self.survivor = host

func update(_delta):
	pass
