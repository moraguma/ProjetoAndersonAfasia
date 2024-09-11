extends Node2D


@onready var label = $Label
@onready var animation_player = $AnimationPlayer


var max = 0
var val = 0


func set_val(new_val, animate=true):
	if new_val > val:
		animation_player.play("gain")
	val = new_val
	update()


func set_max(new_max):
	max = new_max
	update()


func update():
	label.text = str(val) + "/" + str(max) 
