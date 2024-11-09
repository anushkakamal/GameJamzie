extends Node2D
var direction
var speed = 400
var velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = move_and_slide(speed, Vector2.Up)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
