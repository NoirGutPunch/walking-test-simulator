extends Area2D

var direction:= Vector2.RIGHT
var speed = 400
var colors = [
	preload("res://graphics/sprite/vehicules/civic/Black_CIVIC_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/civic/Blue_CIVIC_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/civic/Brown_CIVIC_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/civic/Green_CIVIC_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/civic/Magenta_CIVIC_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/civic/Red_CIVIC_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/civic/White_CIVIC_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/civic/Yellow_CIVIC_CLEAN_EAST_000.png"),
	]

func _ready() -> void:
	$Sprite2D.texture = colors.pick_random()

func _process(delta):
	position += direction * speed * delta
	if global_position.x < -700 or global_position.x > 2000:
		queue_free()
