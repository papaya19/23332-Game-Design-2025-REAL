extends Area2D

@export var destination_scene: String = ""

func _on_body_entered(body):
	if body.name == "player" and destination_scene != "":
		call_deferred("change_scene")

func change_scene():
	var transition = preload("res://scenes/transition_screen.tscn").instantiate()
	get_tree().get_root().add_child(transition)
	transition.slide_and_change_scene(destination_scene)
