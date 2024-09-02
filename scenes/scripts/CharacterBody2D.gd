extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):
	
	var dir = (get_viewport().get_mouse_position() - position).normalized() if Input.is_action_pressed("click") else Vector2(0, 0)
	velocity = dir * SPEED

	move_and_slide()
