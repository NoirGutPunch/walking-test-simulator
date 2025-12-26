extends Panel

#This is how you change the audio bus that godot should adjust when you adjust the slider
@export var audio_bus_name: String
@onready var audio_control: HSlider = $VBoxContainer/HBoxContainer/AudioControl

var audio_bus_id

func _ready() -> void:
	var default_volume = linear_to_db($VBoxContainer/HBoxContainer/AudioControl.value)
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	AudioServer.set_bus_volume_db(audio_bus_id, default_volume)


func _on_audio_control_value_changed(_value: float) -> void:
	var db = linear_to_db($VBoxContainer/HBoxContainer/AudioControl.value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)


func _on_fullscreen_control_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_music_control_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.music_player.stream_paused = false
	else:
		Global.music_player.stream_paused = true
