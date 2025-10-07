# Jogo de Afasia por um Afásico
# Copyright (C) 2025 Gustavo Araújo Morais
# 
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

extends TextureButton


@export var correto: bool


@onready var base = $"../../../"
@onready var win = $Win
@onready var shadow = $Shadow


func _ready():
	if correto:
		pressed.connect(base.acertou.bind(self))
		if Globals.has_guessed(get_id()):
			display_win()
	else:
		pressed.connect(base.errou.bind(self))
	
	win.texture = texture_normal
	shadow.texture = texture_normal


func display_win():
	win.show()


func get_id():
	return Globals.get_last_level() + "/" + name 
