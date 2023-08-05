extends VideoStreamPlayer


func _on_finished() -> void:
	Globals.intro_finished = true
	get_tree().change_scene_to_file("res://world/second_level.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		finished.emit()
