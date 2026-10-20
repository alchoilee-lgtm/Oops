extends AudioStreamPlayer


func _process(delta: float) -> void:
	if Global.death_cause == 1 or Global.death_cause == 2 or Global.death_cause == -2 or Global.death_cause == -1:
			volume_db = -80
