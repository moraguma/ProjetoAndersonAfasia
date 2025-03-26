extends "res://addons/jam_essentials/scenes/components/scripts/TransitionButton.gd"


func _pressed():
	super()
	if Globals.has_completed():
		Globals.reset_game()
