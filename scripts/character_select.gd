# CharacterSelect.gd
extends Control

func _on_charactor_1_pressed() -> void:
	Global.selected_character = "Charactor 1"
	print("Mariah")
	load_game()
	
func _on_charactor_2_pressed() -> void:
	Global.selected_character = "Charactor 2"
	print("ash selected")
	load_game()
	
func load_game():
	get_tree().change_scene_to_file("res://Game.tscn")
