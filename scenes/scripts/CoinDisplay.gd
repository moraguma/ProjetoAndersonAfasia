# Jogo de Afasia por um Afásico
# Copyright (C) 2025 Gustavo Araújo Morais
# 
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

extends Node2D


@onready var label = $Label
@onready var animation_player = $AnimationPlayer


var max = 0
var val = 0


func set_val(new_val, animate=true):
	if new_val > val:
		animation_player.play("gain")
	val = new_val
	update()


func set_max(new_max):
	max = new_max
	update()


func update():
	label.text = str(val) + "/" + str(max) 
