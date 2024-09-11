extends Node2D


func _ready():
	SoundController.mute_music()


func exit(button=false):
	if button:
		SoundController.play_sfx("Button")
		$VideoStreamPlayer.stop()
	SoundController.play_music("Music")
	SceneManager.goto_scene("res://scenes/Menu.tscn")
