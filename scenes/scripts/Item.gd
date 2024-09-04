extends TextureButton


@export var correto: bool


func _ready():
	if correto:
		pressed.connect(get_parent().acertou)
	else:
		pressed.connect(get_parent().errou)
	
	$Shadow.texture = texture_normal
