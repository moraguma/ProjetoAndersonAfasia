extends TextureButton


@export var correto: bool


@onready var base = $"../../../"


func _ready():
	if correto:
		pressed.connect(base.acertou)
	else:
		pressed.connect(base.errou)
	
	$Shadow.texture = texture_normal
