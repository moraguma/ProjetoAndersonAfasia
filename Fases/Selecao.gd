extends Node2D

func _ready():
	$Pergunta.play()


func acertou():
	Mostrador.mostrar(true)
	sair()


func errou():
	Mostrador.mostrar(false)
	sair()


func sair():
	get_tree().change_scene_to_file("res://nivel.tscn")


func _on_audio_stream_player_tree_entered():
	pass # Replace with function body.
