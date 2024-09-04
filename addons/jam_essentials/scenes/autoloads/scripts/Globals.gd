extends Node


const MASTER_BUS = 0
const MUSIC_BUS = 1
const SFX_BUS = 2
const BUS_TO_STRING = {
	MASTER_BUS: "Master",
	MUSIC_BUS: "Music",
	SFX_BUS: "SFX"
}
const TTS_VOL = 200
const TTS_FALLBACK = {
	"Escolha seu personagem": preload("res://resources/sounds/tts/playerselection.mp3"),
	"Onde você pode sentar?": preload("res://resources/sounds/tts/1prompt.mp3"),
	"Parabéns! Dá pra sentar nisso!": preload("res://resources/sounds/tts/1win.mp3"),
	"Não dá pra sentar nisso!": preload("res://resources/sounds/tts/1lose.mp3"),
	"Qual esporte usa bola?": preload("res://resources/sounds/tts/2prompt.mp3"),
	"Parabéns! Esse esporte usa bola!": preload("res://resources/sounds/tts/2win.mp3"),
	"Esse esporte não usa bola!": preload("res://resources/sounds/tts/2lose.mp3"),
	"O que ajuda a proteger do sol na cabeça?": preload("res://resources/sounds/tts/3prompt.mp3"),
	"Parabéns! Isso protege do sol!": preload("res://resources/sounds/tts/3win.mp3"),
	"Isso não protege do sol!": preload("res://resources/sounds/tts/3lose.mp3"),
	"O que eu posso usar para ver as horas": preload("res://resources/sounds/tts/4prompt.mp3"),
	"Parabéns! Isso se usa pra ver as horas!": preload("res://resources/sounds/tts/4win.mp3"),
	"Isso não ajuda a ver as horas!": preload("res://resources/sounds/tts/4lose.mp3"),
	"Onde você pode deitar para dormir?": preload("res://resources/sounds/tts/5prompt.mp3"),
	"Parabéns! Dá pra dormir nisso!": preload("res://resources/sounds/tts/5win.mp3"),
	"Não dá pra dormir nisso!": preload("res://resources/sounds/tts/5lose.mp3"),
	"Onde você pode escrever?": preload("res://resources/sounds/tts/6prompt.mp3"),
	"Parabéns! Dá pra escrever nisso!": preload("res://resources/sounds/tts/6win.mp3"),
	"Não dá pra escrever nisso!": preload("res://resources/sounds/tts/6lose.mp3"),
	"O que você pode beber?": preload("res://resources/sounds/tts/7prompt.mp3"),
	"Parabéns! Dá pra beber isso!": preload("res://resources/sounds/tts/7win.mp3"),
	"Não dá pra beber isso!": preload("res://resources/sounds/tts/7lose.mp3"),
	"Que animal morde?": preload("res://resources/sounds/tts/8prompt.mp3"),
	"Parabéns! Esse animal morde!": preload("res://resources/sounds/tts/8win.mp3"),
	"Esse animal não morde!": preload("res://resources/sounds/tts/8lose.mp3"),
	"O que você pode usar para se locomover?": preload("res://resources/sounds/tts/9prompt.mp3"),
	"Parabéns! Dá pra se locomover nisso!": preload("res://resources/sounds/tts/9win.mp3"),
	"Não dá pra se locomover nisso!": preload("res://resources/sounds/tts/9lose.mp3"),
	"O que te ajuda a enxergar melhor?": preload("res://resources/sounds/tts/10prompt.mp3"),
	"Parabéns! Isso ajuda a enxergar melhor!": preload("res://resources/sounds/tts/10win.mp3"),
	"Isso não ajuda a enxergar!": preload("res://resources/sounds/tts/10lose.mp3")
}


var levels_beat = {}
var player = 2
var last_level = "start"
var last_level_int = 0


var voice_id = null


@onready var tts_fallback: AudioStreamPlayer = $TTSFallback


func _ready() -> void:
	var voices = DisplayServer.tts_get_voices_for_language("pt")
	if len(voices) > 0:
		voice_id = voices[0]



## If the given check is true, pushes a warning message and returns true.
## Otherwise, returns false
func check_and_error(check: bool, message: String):
	if check:
		push_error(message)
		return true
	return false


func beat_level(level: int):
	levels_beat[level] = true


func is_level_beat(level: int):
	if level in levels_beat:
		return levels_beat[level]
	return false


func tts(str):
	if voice_id != null:
		DisplayServer.tts_stop()
		DisplayServer.tts_speak(str, voice_id, TTS_VOL)
	elif str in TTS_FALLBACK:
		tts_fallback.stop()
		tts_fallback.stream = TTS_FALLBACK[str]
		tts_fallback.play()
