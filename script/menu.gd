extends Node2D
var space_pressed = false
signal start

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and space_pressed == false:
		start.emit()
		space_pressed = true
