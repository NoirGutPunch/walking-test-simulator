extends HSlider

#This is how you change the audio bus that godot should adjust when you adjust the slider
@export var audio_bus_name: String

var audio_bus_id
var default_volume = linear_to_db(value)

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	AudioServer.set_bus_volume_db(audio_bus_id, default_volume)

func _on_value_changed(_value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
