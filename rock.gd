extends Node2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random = RandomNumberGenerator.new()
	random.randomize()
	var frame_number = random.randi_range(0,3)
	$Sprite2D.frame = frame_number

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += delta * speed
