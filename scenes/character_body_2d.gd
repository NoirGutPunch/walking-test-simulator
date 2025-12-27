extends CharacterBody2D

@export var speed := 400

# Current input direction (what keys are pressed right now)
var direction := Vector2.ZERO

# Last non-zero direction the player moved in
# Used to decide which idle animation to play
var facing := Vector2.DOWN

func get_input():
	# Read player input as a normalized Vector2
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Apply movement speed
	velocity = direction * speed
	
	# Only update facing when there IS input
	# This preserves the last direction when the player stops
	if direction != Vector2.ZERO:
		facing = direction

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	play_walk_animation()

func play_walk_animation():
	# If not moving, switch to idle logic
	if direction == Vector2.ZERO:
		play_idle_animation()
		return
	
	# If horizontal movement is stronger than vertical
	if abs(direction.x) > abs(direction.y):
		# Play right animation and flip if moving left
		$AnimatedSprite2D.play("walk_right")
		$AnimatedSprite2D.flip_h = direction.x < 0
	
	# Otherwise, check vertical movement
	elif direction.y > 0:
		# Moving down
		$AnimatedSprite2D.play("walk_down")
	else:
		# Moving up
		$AnimatedSprite2D.play("walk_up")

func play_idle_animation():
	# Decide idle animation based on LAST facing direction
	
	# If last movement was mostly horizontal
	if abs(facing.x) > abs(facing.y):
		# Idle right, flipped if facing left
		$AnimatedSprite2D.play("idle_right")
		$AnimatedSprite2D.flip_h = facing.x < 0
	
	# Otherwise, use vertical facing
	elif facing.y > 0:
		# Idle facing down
		$AnimatedSprite2D.play("idle_down")
	else:
		# Idle facing up
		$AnimatedSprite2D.play("idle_up")
