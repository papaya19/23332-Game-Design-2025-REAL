extends Node

@onready var audio_player = $AudioStreamPlayer2D

func _ready():
	# Connect to the signal for future scene changes.
	get_tree().tree_changed.connect(on_scene_changed)
	
	# Call the function 'deferred' to wait until the scene tree is ready.
	call_deferred("on_scene_changed")


# This function runs automatically whenever the scene tree changes.
func on_scene_changed():
	# FIX: The most robust check. If the node isn't fully in the tree,
	# do nothing to prevent any errors.
	if not is_inside_tree():
		return

	var new_scene = get_tree().current_scene
	
	# Add a check to make sure new_scene is not null.
	if new_scene:
		# Check if the new scene is part of the "no_music" group.
		if new_scene.is_in_group("no_music"):
			audio_player.stop()
		else:
			# If it's not a "no_music" scene, and the music isn't
			# already playing, then start it.
			if not audio_player.playing:
				audio_player.play()
