extends HBoxContainer


@export var text: String
@export var say_on_ready = true


@onready var label = $TextContainer/Text


func _ready() -> void:
	update_text()
	$SoundButton.pressed.connect(say)
	if say_on_ready:
		say()


func update_text():
	label.text = "[center]%s" % [text]


func say():
	Globals.tts(text)
