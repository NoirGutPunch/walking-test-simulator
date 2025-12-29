extends Area2D

var direction:= Vector2.RIGHT
var speed = 400
var colors = [
	preload("res://graphics/sprite/vehicules/micro/Black_MICRO_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/micro/Blue_MICRO_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/micro/Brown_MICRO_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/micro/Green_MICRO_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/micro/Magenta_MICRO_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/micro/Red_MICRO_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/micro/White_MICRO_CLEAN_EAST_000.png"),
	preload("res://graphics/sprite/vehicules/micro/Yellow_MICRO_CLEAN_EAST_000.png"),
	]

func _ready() -> void:
	$Sprite2D.texture = colors.pick_random()

func _process(delta):
	position += direction * speed * delta
	if global_position.x < -700 or global_position.x > 2000:
		queue_free()
