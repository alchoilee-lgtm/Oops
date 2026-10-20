extends Node2D
var transition = preload("res://scene/transition.tscn")



func _process(delta: float) -> void:
	if Global.death_cause == 1 or Global.death_cause == -1:
		$"UntitledDrawing(39)".visible = true
	else:
		$"UntitledDrawing(39)".visible = false

	if Global.death_cause == 2 or Global.death_cause == -2:
		$"UntitledDrawing(41)".visible = true
	else:
		$"UntitledDrawing(41)".visible = false
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scene/world.tscn")
	position.y = Global.camera_pos.y - 650
	
	if Global.death_cause == 1 or Global.death_cause == 2:
			$AudioStreamPlayer.playing = true
			if Global.death_cause == 1:
				Global.death_cause = -1
			if Global.death_cause == 2:
				Global.death_cause = -2
