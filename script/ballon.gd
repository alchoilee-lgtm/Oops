extends Sprite2D

var transition = preload("res://scene/transition.tscn")



func _on_menu_start() -> void:
	for i in 46:
		position.y -= 7
		await get_tree().create_timer(0.01).timeout
	await get_tree().create_timer(2).timeout
	var transitionclone = transition.instantiate()
	get_parent().add_child(transitionclone)
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scene/story.tscn")
