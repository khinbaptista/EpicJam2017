extends "res://fsm/state.gd"

func seek():
	machine.make_transition("seek")

func atatck():
	machine.make_transition("attack")
