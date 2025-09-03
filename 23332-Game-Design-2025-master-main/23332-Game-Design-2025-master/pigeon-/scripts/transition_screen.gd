extends CanvasLayer

signal transition_finished
var _target_scene: String = ""
@onready var wipe = $ColorRect

func slide_and_change_scene(scene_path: String):
	_target_scene = scene_path
	wipe.visible = true
	wipe.position.x = -wipe.size.x

	var tween = create_tween()
	tween.tween_property(wipe, "position:x", 0, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_callback(Callable(self, "change_scene"))
	tween.tween_interval(0.2)
	tween.tween_property(wipe, "position:x", 1920, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_callback(Callable(self, "queue_free"))

func change_scene():
	get_tree().change_scene_to_file(_target_scene)



func _on_transition_finished():
	emit_signal("transition_finished")
	queue_free()
