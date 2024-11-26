extends TextureButton


@export var correto: bool


@onready var base = $"../../../"
@onready var win = $Win
@onready var shadow = $Shadow


func _ready():
	if correto:
		pressed.connect(base.acertou.bind(self))
		if Globals.has_guessed(get_id()):
			display_win()
	else:
		pressed.connect(base.errou.bind(self))
	
	win.texture = texture_normal
	shadow.texture = texture_normal


func display_win():
	win.show()


func get_id():
	return Globals.get_last_level() + "/" + name 
