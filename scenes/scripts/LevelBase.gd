extends Node2D


const DELAY = 4.0


@export var win_color: Color
@export var lose_color: Color
@export var prompt: String


var played = false


@onready var display = $Display
@onready var win_indicator = $Display/Win
@onready var lose_indicator = $Display/Lose
@onready var timer = $Timer
@onready var tts = $TTSLabel
@onready var item_container: ScrollContainer = $ItemContainer


func _ready() -> void:
	randomize_scroll.call_deferred()
	
	tts.text = prompt
	tts.update_text()
	tts.say()


func randomize_scroll():
	item_container.scroll_horizontal = randi() % int(item_container.get_h_scroll_bar().max_value)


func acertou():
	if not played:
		Globals.beat_level(Globals.last_level_int)
		SoundController.play_sfx("Win")
		end(win_color, true)


func errou():
	if not played:
		SoundController.play_sfx("Lose")
		end(lose_color, false)


func end(color, won):
	played = true
	
	display.show()
	display.color = color
	if won:
		win_indicator.show()
	else:
		lose_indicator.show()
	
	timer.start(DELAY)
	await timer.timeout
	
	SceneManager.goto_scene("res://scenes/Main.tscn")
