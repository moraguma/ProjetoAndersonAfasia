extends Node2D

const SPEED = 300
const POSITION_DIF = Vector2(0, 0)

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

var current_node = null
var moving = false


func _ready() -> void:
	player.frame = Globals.player
	current_node == "start" if Globals.last_level == "start" else get_node(Globals.last_level)
	
	for level_selector: LevelSelector in level_selector_container.get_children():
		level_selector.go_here.connect(go_here)


func find_path(destiny):
	var queue = []
	var dist = {current_node: 0}
	var par = {}
	while len(queue) > 0:
		var node = queue.pop_front()
		for neighbor in connections[node]:
			if not neighbor in dist:
				par[neighbor] = node
				dist[neighbor] = dist[node] + 1
				queue.append(neighbor)
	
	var result = [current_node]
	var current_node = destiny
	for i in range(dist[destiny]):
		current_node = par[current_node] 
		result.append(current_node)
	result.reverse()
	return result


func go_here(level_selector):
	if not moving:
		moving = true
		
		if not current_node == null:
			current_node.disable_play()
		
		var path = find_path(level_selector)
		var tween = create_tween()
		var past_pos = player.position
		for node in path:
			var new_pos = node.position + POSITION_DIF
			tween.tween_property(player, "position", new_pos, (new_pos - past_pos).length() / SPEED)
			past_pos = new_pos
		await tween.finished
		
		level_selector.enable_play()
		moving = false
