extends Node2D

const SPEED = 600
const POSITION_DIF = Vector2(40, 72)

const PLAYER_AMPLITUDE = 16
const FREQUENCY = 0.5
const MOVING_TIME_MULT = 4
const ANGLE = PI/12
const WIN_WAIT_TIME = 5.0
const MAX_LEVELS = 10

@export var win_color: Color
@export var complete_color: Color

@onready var player_particles: CPUParticles2D = $Player/Particles
@onready var player: Sprite2D = $Player
@onready var connections = {
	"start": [$LevelSelectors/Sentar],
	$LevelSelectors/Sentar: [$LevelSelectors/Bola, $LevelSelectors/Horario],
	$LevelSelectors/Bola: [$LevelSelectors/Sentar, $LevelSelectors/Praia, $LevelSelectors/Escrever],
	$LevelSelectors/Praia: [$LevelSelectors/Bola],
	$LevelSelectors/Horario: [$LevelSelectors/Sentar, $LevelSelectors/Dormir],
	$LevelSelectors/Dormir: [$LevelSelectors/Horario, $LevelSelectors/Transporte, $LevelSelectors/Escrever],
	$LevelSelectors/Escrever: [$LevelSelectors/Dormir, $LevelSelectors/Bebidas, $LevelSelectors/Bola],
	$LevelSelectors/Bebidas: [$LevelSelectors/Escrever, $LevelSelectors/Animal],
	$LevelSelectors/Animal: [$LevelSelectors/Bebidas, $LevelSelectors/Transporte],
	$LevelSelectors/Transporte: [$LevelSelectors/Animal, $LevelSelectors/Dormir, $LevelSelectors/Enxergar],
	$LevelSelectors/Enxergar: [$LevelSelectors/Transporte]
}
@onready var level_selector_container = $LevelSelectors
@onready var footstep_sound = $Footstep
@onready var win_display = $Display
@onready var win_tts = $Display/TTSLabel
@onready var coin_display = $CoinDisplay

var current_node = null
var moving = false
var past_player_pos
var time_passed = 0
var interrupt = false


func _ready() -> void:
	coin_display.set_max(Globals.MAX_COINS)
	coin_display.set_val(Globals.get_total_coins())
	
	var won = Globals.has_beat()
	var completed = Globals.has_completed()
	interrupt = won or completed
	
	if Globals.get_last_level() == "start":
		current_node = "start" 
	else: 
		current_node = get_node("LevelSelectors/%s" % [Globals.get_last_level()])
		if not interrupt:
			current_node.enable_play()
		player.position = current_node.position + POSITION_DIF
	player.frame = Globals.player
	past_player_pos = player.position
	
	for level_selector: LevelSelector in level_selector_container.get_children():
		level_selector.go_here.connect(go_here)
	
	if interrupt:
		if completed:
			win_display.color = complete_color
			Globals.finish_complete()
		else:
			win_display.color = win_color
		Globals.finish_beat()
		
		win_display.show()
		win_tts.say()
		SoundController.play_sfx("Win")
		
		await get_tree().create_timer(WIN_WAIT_TIME).timeout
		
		SceneManager.goto_scene("res://scenes/Menu.tscn")
		return


func _process(delta: float) -> void:
	time_passed += delta * (MOVING_TIME_MULT if moving else 1.0)
	
	var dir = player.position - past_player_pos
	past_player_pos = player.position
	
	player.offset = Vector2(0, PLAYER_AMPLITUDE * cos(2 * PI * FREQUENCY * time_passed))
	var angle = 0
	if dir[0] == 0:
		player.rotation = 0
	elif dir[0] < 0:
		angle = -ANGLE
		player.flip_h = true
	else:
		angle = ANGLE
		player.flip_h = false
	player.rotation = angle
	var height = Vector2(0, player.texture.get_height() / player.vframes / 2 / player.scale[1])
	player.offset += height - height.rotated(-angle)

func find_path(destiny):
	var queue = [current_node]
	var dist = {current_node: 0}
	var par = {}
	while len(queue) > 0:
		var node = queue.pop_front()
		for neighbor in connections[node]:
			if not neighbor in dist:
				par[neighbor] = node
				dist[neighbor] = dist[node] + 1
				queue.append(neighbor)
	
	var current_node = destiny
	var result = [current_node]
	for i in range(dist[destiny]):
		current_node = par[current_node] 
		result.append(current_node)
	result.reverse()
	return result


func go_here(level_selector):
	if (not current_node is String and level_selector == current_node) or moving or interrupt:
		return
	
	moving = true
	footstep_sound.play()
	player_particles.emitting = true
	
	if not current_node is String:
		current_node.disable_play()
	
	var path = find_path(level_selector)
	var tween = create_tween()
	var past_pos = player.position
	for i in range(1, len(path)):
		var node = path[i]
		var new_pos = node.position + POSITION_DIF
		tween.tween_property(player, "position", new_pos, (new_pos - past_pos).length() / SPEED)
		past_pos = new_pos
	await tween.finished
	
	player_particles.emitting = false
	
	current_node = level_selector
	current_node.enable_play()
	moving = false
	footstep_sound.stop()
	SoundController.play_sfx("Level")
