extends Button
@export var destination_scene: String = ""
func _on_pressed():
	call_deferred("change_scene")
	
func change_scene():
	get_tree().change_scene_to_file(destination_scene)
