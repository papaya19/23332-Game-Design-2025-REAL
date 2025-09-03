extends Area2D

@export var destination_scene: String = ""

func _on_body_entered(body):
	if body.name == "player":
		call_deferred("change_scene")

func change_scene():
	if destination_scene != "":
		get_tree().change_scene_to_file(destination_scene)
