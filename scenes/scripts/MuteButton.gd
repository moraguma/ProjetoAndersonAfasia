# Jogo de Afasia por um Afásico
# Copyright (C) 2025 Gustavo Araújo Morais
# 
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.

extends TextureButton


@export var bus: int


var can_press = false


func _ready() -> void:
	button_pressed = not Globals.get_bus(bus)
	can_press = true


func _pressed() -> void:
	if not can_press:
		return
	
	SoundController.play_sfx("Button")
	Globals.set_bus(bus, not button_pressed)
