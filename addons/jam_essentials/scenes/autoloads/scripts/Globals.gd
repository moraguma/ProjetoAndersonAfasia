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
	"Escolha seu personagem": preload("res://resources/sounds/tts/playerselection.mp3"),
	"Assistente de voz habilitado": preload("res://resources/sounds/tts/ttsenabled.mp3"),
	"Assistente de voz desabilitado": preload("res://resources/sounds/tts/ttsdisabled.mp3"),
	"Onde você pode sentar?": preload("res://resources/sounds/tts/p1.wav"),
	"Qual esporte é possível se você joga com uma bola?": preload("res://resources/sounds/tts/p2.wav"),
	"O que ajuda a proteger do sol na cabeça?": preload("res://resources/sounds/tts/p3.wav"),
	"O que eu posso usar para ver as horas": preload("res://resources/sounds/tts/p4.wav"),
	"Onde você pode deitar para dormir?": preload("res://resources/sounds/tts/p5.wav"),
	"Onde você pode escrever?": preload("res://resources/sounds/tts/p6.wav"),
	"O que você pode beber?": preload("res://resources/sounds/tts/p7.wav"),
	"Que animal vive no mar?": preload("res://resources/sounds/tts/p8.wav"),
	"O que você pode usar para se locomover?": preload("res://resources/sounds/tts/p9.wav"),
	"O que te ajuda a enxergar melhor?": preload("res://resources/sounds/tts/p10.wav"),
}


var levels_beat = {}
var player = 2
var last_level = "start"
var last_level_int = 0
var bus_status = {
	MUSIC_BUS: true,
	SFX_BUS: true,
	TTS_BUS: true
}
var beat_counter = 0


var voice_id = null


@onready var tts_fallback: AudioStreamPlayer = $TTSFallback


func _ready() -> void:
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


func beat_level(level: int):
	if not is_level_beat(level):
		beat_counter += 1
	
	levels_beat[level] = true


func is_level_beat(level: int):
	if level in levels_beat:
		return levels_beat[level]
	return false


func get_beat_counter():
	return beat_counter


func reset():
	beat_counter = 0
	levels_beat = {}
	last_level = "start"


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
