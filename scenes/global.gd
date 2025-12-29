extends Node
#turn on autoplay before shipping the game!
@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

# This variable will stay true until you close the game
var has_seen_level1_cutscene1: bool = false
