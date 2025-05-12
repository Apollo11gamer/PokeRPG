extends Node2D

@onready var player = $Player
@onready var character_spawn_point = $CharacterSpawnPoint

var ZOOM = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var char_scene : PackedScene
	match Global.selected_character:
		"Charactor 1":
			char_scene = load("res://Ash.tscn")
		"Charactor 2":
			char_scene = load("res://Main charactor.tscn")
		_:
			push_error("No character selected!")
			return

	var character = char_scene.instantiate()
	character_spawn_point.add_child(character)
	
	if player:
		var cam = player.get_child(0)
		cam.zoom = Vector2(ZOOM,ZOOM)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if player:
		print("Body entered")
		get_tree().change_scene_to_file("res://scenes/Underwater.tscn")
	
