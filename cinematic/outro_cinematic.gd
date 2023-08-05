extends VideoStreamPlayer


func _on_finished() -> void:
	get_tree().quit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		finished.emit()
