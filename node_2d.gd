extends Node2D

@onready var player = $Player

var ZOOM = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		var cam = player.get_child(0)
		cam.zoom = Vector2(ZOOM,ZOOM)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if player:
		print("Body entered")
		get_tree().change_scene_to_file("res://scenes/Underwater.tscn")
	
