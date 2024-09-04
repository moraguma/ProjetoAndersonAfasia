extends Button
class_name LevelSelector


signal go_here(node)


const LERP_WEIGHT = 0.15
const BASE_PLAY_SCALE = Vector2(8, 8)
const OFF_PLAY_SCALE = Vector2(0, 0)


@export var level: int


var can_play = false


@onready var play_holder: Node2D = $PlayHolder
@onready var play_button: TextureButton = $PlayHolder/Play
@onready var sprite: AnimatedSprite2D = $Flag
@onready var label: Label = $LabelHolder/Label


func _ready() -> void:
	label.text = str(level)
	sprite.play("beat" if Globals.is_level_beat(level) else "not_beat")
	play_button.pressed.connect(try_play)


func _process(delta: float) -> void:
	play_holder.scale = lerp(play_holder.scale, BASE_PLAY_SCALE if can_play else OFF_PLAY_SCALE, LERP_WEIGHT)


func try_play():
	if can_play:
		Globals.last_level = name
		Globals.last_level_int = level
		SceneManager.goto_scene("res://scenes/levels/%d.tscn" % [level])


func enable_play():
	can_play = true


func disable_play():
	can_play = false


func _pressed() -> void:
	go_here.emit(self)
