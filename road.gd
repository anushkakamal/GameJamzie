extends Node2D

var collision_y: int
var total_jump_time = 70
@onready
var player_status = {
	'left': {'character': get_tree().current_scene.get_node('LeftCharacter'), 'key_name': 'Jump_Left', 'jump_time': 0},
'right': {'character': get_tree().current_scene.get_node('RightCharacter'), 'key_name': 'Jump_Right', 'jump_time': 0},
}
var obstacle = preload("res://rock.tscn")
var road = preload('res://road_segment.tscn')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var road_segment = road.instantiate()
	$Road/RoadSpawnMarker.add_child(road_segment)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	

	for character_side in player_status.keys():
		_jumping_on(character_side)
		_jump_count_down(character_side)
		_player_animation(character_side)

	place_rock()
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.

func _jump_count_down(character_side: String) -> void:
	if player_status[character_side]['jump_time'] > 0:
		player_status[character_side]['jump_time'] -= 1
		print('character jumping: seconds', player_status[character_side]['jump_time'], 'side: ', character_side)
	
func _player_animation(character_side: String) -> void: 
	var player_animation = player_status[character_side]['character'].get_node('AnimationPlayer')

	if player_status[character_side]['jump_time'] == 0: 
		player_animation.play('Idle')
		print('idle')
	else:
		player_animation.play('Jump')
		print('jump')
		

func _jumping_on(character_side: String) -> void:
	var current_character = player_status[character_side]
	print(current_character)
	if Input.is_action_just_pressed(current_character['key_name']):
		print('jumping side: ', current_character['key_name'])
		current_character['jump_time'] = total_jump_time
		
func place_rock() -> void:
	var new_obstacle = obstacle.instantiate()
	$Road/RockSpawnLeft.add_child(new_obstacle)
	
