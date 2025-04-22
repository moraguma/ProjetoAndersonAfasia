extends Node


const MASTER_BUS = 0
const MUSIC_BUS = 1
const SFX_BUS = 2
const TTS_BUS = 3
const BUS_TO_STRING = {
	MASTER_BUS: "Master",
	MUSIC_BUS: "Music",
	SFX_BUS: "SFX"
}
const TTS_VOL = 200
const TTS_FALLBACK = {
	"Escolha seu personagem": preload("res://resources/sounds/tts/player_selection.wav"),
	"Assistente de voz habilitado": preload("res://resources/sounds/tts/ttsenabled.mp3"),
	"Assistente de voz desabilitado": preload("res://resources/sounds/tts/ttsdisabled.mp3"),
	"Onde você pode sentar?": preload("res://resources/sounds/tts/p1.wav"),
	"Qual esporte é jogado com bola?": preload("res://resources/sounds/tts/p2.wav"),
	"O que ajuda a proteger a minha cabeça no sol": preload("res://resources/sounds/tts/p3.wav"),
	"Onde eu posso ver as horas?": preload("res://resources/sounds/tts/p4.wav"),
	"Onde você pode dormir?": preload("res://resources/sounds/tts/p5.wav"),
	"Onde você pode escrever?": preload("res://resources/sounds/tts/p6.wav"),
	"O que você pode beber e não faz mal?": preload("res://resources/sounds/tts/p7.wav"),
	"Que animal vive no mar?": preload("res://resources/sounds/tts/p8.wav"),
	"O que eu uso como transporte?": preload("res://resources/sounds/tts/p9.wav"),
	"O que te ajuda a enxergar melhor?": preload("res://resources/sounds/tts/p10.wav"),
	"Parabéns, você terminou o jogo!": preload("res://resources/sounds/tts/ending.mp3")
}


const SAVE_PATH = "user://save.tres"


const MAX_COINS = 50
const MAX_LEVELS = 10


var player = 2
var bus_status = {
	MUSIC_BUS: true,
	SFX_BUS: true,
	TTS_BUS: true
}
var voice_id = null

var save: SaveFile


@onready var tts_fallback: AudioStreamPlayer = $TTSFallback


func _ready() -> void:
	load_game()
	var voices = DisplayServer.tts_get_voices_for_language("pt")
	if len(voices) > 0:
		voice_id = voices[0]
		voice_id = null



## If the given check is true, pushes a warning message and returns true.
## Otherwise, returns false
func check_and_error(check: bool, message: String):
	if check:
		push_error(message)
		return true
	return false


func tts(str, force=false):
	if not bus_status[TTS_BUS] and not force:
		return 
	
	SoundController.mute_music()
	if voice_id != null:
		DisplayServer.tts_stop()
		DisplayServer.tts_speak(str, voice_id, TTS_VOL)
	elif str in TTS_FALLBACK:
		tts_fallback.stop()
		tts_fallback.stream = TTS_FALLBACK[str]
		tts_fallback.play()


func set_bus(bus: int, status):
	if bus != TTS_BUS:
		SoundController.set_volume(bus, 1.0 if status else 0.0)
	else:
		tts("Assistente de voz habilitado" if status else "Assistente de voz desabilitado", true)
	bus_status[bus] = status


func get_bus(bus: int):
	return bus_status[bus]


func tts_finished() -> void:
	SoundController.unmute_music()


# --------------------------------------------------------------------------------------------------
# SAVE
# --------------------------------------------------------------------------------------------------
func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		save = SaveFile.new()
		save_game()
	
	save = load(SAVE_PATH)


func reset_game():
	save = SaveFile.new()
	save_game()


func save_game():
	ResourceSaver.save(save, SAVE_PATH)


func complete_level(level: int):
	if not is_level_complete(level):
		save.complete_counter += 1
	
	save.levels_completed[level] = true
	save_game()


func is_level_complete(level: int):
	if level in save.levels_completed:
		return save.levels_completed[level]
	return false


func get_complete_counter():
	return save.complete_counter


func beat_level(level: int):
	if not is_level_beat(level):
		save.beat_counter += 1
	
	save.levels_beat[level] = true
	save_game()


func is_level_beat(level: int):
	if level in save.levels_beat:
		return save.levels_beat[level]
	return false


func get_beat_counter():
	return save.beat_counter


func finish_beat():
	save.beat_counter = -1
	save_game()


func finish_complete():
	save_game()


func try_guess(guess):
	if not guess in save.correct_guesses:
		save.correct_guesses[guess] = true
		save.total_coins += 1
		save_game()


func has_beat():
	return get_beat_counter() >= MAX_LEVELS


func has_completed():
	return get_complete_counter() >= MAX_LEVELS


func has_guessed(guess):
	if guess in save.correct_guesses:
		return save.correct_guesses[guess]
	return false


func get_total_coins():
	return save.total_coins


func get_last_level():
	return save.last_level


func set_last_level(val):
	save.last_level = val


func set_last_level_int(val):
	save.last_level_int = val


func get_last_level_int():
	return save.last_level_int
