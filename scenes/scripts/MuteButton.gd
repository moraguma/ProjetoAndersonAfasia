extends TextureButton


@export var bus: int


var can_press = false


func _ready() -> void:
	button_pressed = not Globals.get_bus(bus)
	can_press = true


func _pressed() -> void:
	if not can_press:
		return
	
	SoundController.play_sfx("Button")
	Globals.set_bus(bus, not button_pressed)
