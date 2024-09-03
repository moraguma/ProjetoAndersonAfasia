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
	SceneManager.goto_scene("res://scenes/Main.tscn")


func _on_audio_stream_player_tree_entered():
	pass # Replace with function body.
