extends Node2D

var collision_y: int
var total_jump_time = 100
#@onready
#var character_left = get_tree().current_scene.get_node('Car')
#@onready
#var character_right = $Car2
@onready
var player_status = {
	'left': {'character': get_tree().current_scene.get_node('LeftCharacter'), 'key_name': 'Jump_Left', 'jump_time': 0},
'right': {'character': get_tree().current_scene.get_node('RightCharacter'), 'key_name': 'Jump_Right', 'jump_time': 0},
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Road.position.y += 1

	for character_side in player_status.keys():
		_jumping_on(character_side)
		_jump_count_down(character_side)
		_jumping_animation(character_side)

	
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.

func _jump_count_down(character_side: String) -> void:
	if player_status[character_side]['jump_time'] > 0:
		player_status[character_side]['jump_time'] -= 1
		print('character jumping: seconds', player_status[character_side]['jump_time'], 'side: ', character_side)
	
func _jumping_animation(character_side: String) -> void: 
	if player_status[character_side]['jump_time'] == 0: 
		var anim_left = player_status[character_side]['character'].get_node('AnimationPlayer')
		anim_left.play('Idle')

func _jumping_on(character_side: String) -> void:
	var current_character = player_status[character_side]
	if Input.is_action_just_pressed(current_character['key_name']):
		print('jumping side: ', current_character['key_name'])
		current_character['jump_status'] = true
		current_character['jump_time'] = total_jump_time
		_jump_count_down(character_side)
		
