extends Node2D
var direction
var speed = 400
var velocity
var collision_y: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_y = $Car2.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Road.position.y += 1
	if $"Road/Sprite2D - obstacle".position.y == collision_y:
		print('collis')
	
	#if $"Sprite2D - obstacle".position.y == 
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
