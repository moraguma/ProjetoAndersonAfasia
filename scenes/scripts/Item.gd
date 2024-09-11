extends TextureButton


@export var correto: bool
var guessed = false


@onready var base = $"../../../"


func _ready():
	if correto:
		pressed.connect(base.acertou)
		try_update()
	else:
		pressed.connect(base.errou)
	
	$Win.texture = texture_normal
	$Shadow.texture = texture_normal


func display_win():
	$Win.show()
	guessed = true


func try_update():
	if Globals.has_guessed(get_id()):
		display_win()


func get_id():
	return Globals.last_level + "/" + name 


func _pressed() -> void:
	if correto and not guessed:
		get_parent().get_parent().get_parent().total_correct_guesses += 1
		Globals.try_guess(get_id())
		try_update()
