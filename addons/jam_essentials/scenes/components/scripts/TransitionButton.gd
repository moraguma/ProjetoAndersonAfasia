extends BaseButton


@export var transition_path: String


func _pressed():
	SoundController.play_sfx("Button")
	SceneManager.goto_scene(transition_path)
