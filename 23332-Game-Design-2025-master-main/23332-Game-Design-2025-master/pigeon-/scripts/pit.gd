extends Area2D
func _on_body_entered(body):
	if body.name == 'player':
		call_deferred("change_scene")
		
func change_scene():
	get_tree().change_scene_to_file("res://scenes/torielLevel2.tscn")
