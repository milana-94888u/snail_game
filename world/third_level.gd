extends TileMap


func _on_broken_snail_grape_picked(grape: Grape) -> void:
	remove_child(grape)
	if $BrokenSnail/Control/VBoxContainer/Grapes/ProgressBar.value == 5:
		get_tree().change_scene_to_file("res://world/fourth_level.tscn")
