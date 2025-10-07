# Jogo de Afasia por um Afásico
# Copyright (C) 2025 Gustavo Araújo Morais
# 
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

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
