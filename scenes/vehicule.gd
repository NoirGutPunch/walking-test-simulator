extends Area2D

var direction:= Vector2.RIGHT
var speed = 300

func _process(delta):
	position += direction * speed * delta
	if global_position.x < -700 or global_position.x > 2000:
		queue_free()
