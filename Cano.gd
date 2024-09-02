extends Area2D


@export var caminho_do_nivel: String



func _on_body_entered(body):
	print('entrou')
	get_tree().change_scene_to_file(caminho_do_nivel)
