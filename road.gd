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
var road_y = -3840
@export var obstacle_chance: float = 0.3
@export var obstacle_scene: PackedScene
@export var platform_width: int = 200
@export var initial_platform_count: int = 5
var spawner_time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	

	for i in 3:
		var road_segment = road.instantiate()
		$Road/RoadSpawnMarker.add_child(road_segment)
		road_segment.position = Vector2(0, road_y)
		road_y += 1920
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Road/RoadSpawnMarker.position.y += 2
	if $Road/RoadSpawnMarker.position.y >= 1920:
		$Road/RoadSpawnMarker.position.y -= 1920
	
	if spawner_time <= 0:
		_place_rock()
		var random = RandomNumberGenerator.new()
		random.randomize()
		spawner_time = random.randi_range(0,3) 
	spawner_time -= delta
	

	for character_side in player_status.keys():
		_jumping_on(character_side)
		_jump_count_down(character_side)
		_player_animation(character_side)
	

func add_obstacle_to_platform():
	obstacle_scene = preload('res://rock.tscn')
	var obstacle = obstacle_scene.instantiate()
	obstacle.position = Vector2(randf_range(-platform_width / 2, platform_width / 2), -30)
	$Road/RoadSpawnMarker.add_child(obstacle)
	obstacle.position = Vector2.ZERO

	# Connect obstacle collision signal to end the game if either player hits it
	if obstacle.has_signal("player_collided"):
		obstacle.connect("player_collided", Callable(self, "_on_player_collision"))

func _on_player_collision():
	# End the game if either player collides
	print("Game Over! A player collided with an obstacle.")
	#get_tree().paused = true
	#restart_button.visible = true

	if randf() < obstacle_chance:
		add_obstacle_to_platform()


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
		
func _place_rock() -> void:
	var new_obstacle = obstacle.instantiate()
	var r = randi_range(0,1)
	if r == 0:
		$Road/RockSpawnLeft.add_child(new_obstacle)
	if r == 1:
		$Road/RockSpawnRight.add_child(new_obstacle)
	
