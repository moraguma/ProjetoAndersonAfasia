extends Node2D


const DELAY = 3.0


@export var win_color: Color
@export var lose_color: Color
@export var win_text: String
@export var lose_text: String
@export var prompt: String


var played = false


@onready var display = $Display
@onready var success = $Display/Success
@onready var timer = $Timer
@onready var tts = $TTSLabel


func _ready() -> void:
	tts.text = prompt
	tts.update_text()
	tts.say()


func acertou():
	if not played:
		Globals.beat_level(Globals.last_level_int)
		end(win_color, win_text)


func errou():
	if not played:
		end(lose_color, lose_text)


func end(color, text):
	played = true
		
	display.show()
	display.color = color
	success.text = text
	success.update_text()
	success.say()
	
	timer.start(DELAY)
	await timer.timeout
	
	SceneManager.goto_scene("res://scenes/Main.tscn")