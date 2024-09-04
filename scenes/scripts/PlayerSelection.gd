extends Node2D


@onready var players = $Players.get_children()


func _ready() -> void:
	for i in range(len(players)):
		players[i].pressed.connect(start.bind(i))


func start(val): 
	Globals.player = val
	SceneManager.goto_scene("res://scenes/Main.tscn")
