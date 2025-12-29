extends Node2D

var vehicule_scene = [
	preload("res://scenes/vehicule.tscn"),
	preload("res://scenes/vehicule2.tscn")
	]
# 1. WE NEED TO GET THE PLAYER SO WE CAN MEASURE DISTANCE [cite: 6, 42]
# In your scene tree, Player is inside the "Objects" node.
@onready var player = $Objects/Player
@onready var options: Panel = $Other/OptionMenu/Options
@onready var animation_player: AnimationPlayer = $Cutscene1/AnimationPlayer
@onready var cutscene_camera: Camera2D = $Objects/Player/CutsceneCamera


# 2. DEFINE THE DISTANCE (How close must the player be?)
var activation_distance := 2000.0
var is_opening_cutscene = false
var has_player_entered_area = false
var cut_scene_triggerer = null


func _ready() -> void:
	options.visible = false
	animation_player.pause()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		options.visible = !options.visible  # This toggles it (on if off, off if on)

func _on_finish_area_2d_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/success_menu.tscn")


func _on_vehicule_timer_timeout() -> void:
	var markers = $VehiculeStartPosition.get_children()
	
	# 4. THE LOOP
	# "spawn_point" is created here. It represents one marker at a time.
	for spawn_point in markers:
		# Check distance between Player and THIS specific marker
		var dist = player.global_position.distance_to(spawn_point.global_position)
		# Only spawn if the player is close enough
		if dist < activation_distance:
			spawn_vehicule_at(spawn_point)

# 5. THE HELPER FUNCTION
# This handles the actual creation of the car
func spawn_vehicule_at(marker_node):
	var vehicule = vehicule_scene.pick_random().instantiate() as Area2D
	
	$Objects.add_child(vehicule)
	# Set position to the marker's position
	vehicule.global_position = marker_node.global_position
	
	# OPTIONAL: Set direction based on marker name
	if "Left" in marker_node.name:
		vehicule.direction = Vector2.RIGHT
	else:
		vehicule.direction = Vector2.LEFT
		vehicule.scale.x = -1 # Flip the sprite
		
	vehicule.connect("body_entered", go_to_title)


func go_to_title(_body):
	get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")


func _on_back_to_game_button_pressed() -> void:
	_ready()


func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_middle_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("cut_scene_triggerer"):
		cut_scene_triggerer = body
		if !has_player_entered_area:
			has_player_entered_area = true
			if global_file.has_seen_level1_cutscene1 == false:
				global_file.has_seen_level1_cutscene1 = true
				cutscene1()


func cutscene1():
	is_opening_cutscene = true
	animation_player.play("Cutscene_1")
	cutscene_camera.make_current()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	player.camera_2d.reset_smoothing()
	player.camera_2d.make_current()
