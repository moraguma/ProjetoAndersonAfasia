extends Node2D


const DELAY = 4.0


@export var win_color: Color
@export var lose_color: Color
@export var prompt: String


var played = false
var total_correct_guesses = 0
var total_correct_answers = 0


@onready var display = $Display
@onready var win_indicator = $Display/Win
@onready var lose_indicator = $Display/Lose
@onready var timer = $Timer
@onready var tts = $TTSLabel
@onready var item_container: ScrollContainer = $ItemContainer
@onready var items = $ItemContainer/Container.get_children()
@onready var coins = $Coins


func _ready() -> void:
	for item in items:
		if item.correto:
			total_correct_answers += 1
			if item.guessed:
				total_correct_guesses += 1
	update_coins()
	
	randomize_scroll.call_deferred()
	
	tts.text = prompt
	tts.update_text()
	tts.say()


func update_coins():
	coins.text = str(total_correct_guesses) + "/" + str(total_correct_answers)


func randomize_scroll():
	item_container.scroll_horizontal = randi() % int(item_container.get_h_scroll_bar().max_value)


func acertou():
	if not played:
		Globals.beat_level(Globals.last_level_int)
		SoundController.play_sfx("Win")
		end(win_color, true)
		update_coins()


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
