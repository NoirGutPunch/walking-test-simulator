extends Node2D


func _on_next_level_button_pressed() -> void:
	pass


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
