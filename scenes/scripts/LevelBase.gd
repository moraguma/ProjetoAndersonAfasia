extends Node2D


const DELAY = 4.0


@export var win_color: Color
@export var lose_color: Color
@export var complete_color: Color
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
@onready var coin_display = $CoinDisplay
@onready var try_again_display = $Display/TryAgain
@onready var exit_display = $Display/Exit


func _ready() -> void:
	for item in items:
		if item.correto:
			total_correct_answers += 1
			if Globals.has_guessed(item.get_id()):
				total_correct_guesses += 1
	coin_display.set_max(total_correct_answers)
	coin_display.set_val(total_correct_guesses)
	
	randomize_scroll.call_deferred()
	
	tts.text = prompt
	tts.update_text()
	tts.say()


func randomize_scroll():
	item_container.scroll_horizontal = randi() % int(item_container.get_h_scroll_bar().max_value)


func acertou(node):
	if not played:
		var id = node.get_id()
		if not Globals.has_guessed(id):
			Globals.try_guess(id)
			
			total_correct_guesses += 1
			coin_display.set_val(total_correct_guesses)
			
			node.display_win()
		
		Globals.beat_level(Globals.get_last_level_int())
		SoundController.play_sfx("Win")
		end(win_color, true)
		


func errou(node):
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
	
	if total_correct_answers == total_correct_guesses and won:
		Globals.complete_level(Globals.get_last_level_int())
		
		display.color = complete_color
		try_again_display.hide()
		exit_display.hide()
		
		await get_tree().create_timer(DELAY).timeout
		SceneManager.goto_scene("res://scenes/Main.tscn")


func try_again() -> void:
	SoundController.play_sfx("Button")
	
	played = false
	display.hide()
	win_indicator.hide()
	lose_indicator.hide()


func back() -> void:
	SoundController.play_sfx("Button")
	
	SceneManager.goto_scene("res://scenes/Main.tscn")
