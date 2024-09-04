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


var levels_beat = {}
var player = 2
var last_level = "start"
var last_level_int = 0


var voice_id = null


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
