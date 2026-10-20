extends Node2D



func _on_two_timeout() -> void:
	for i in range(10):
		modulate.a -= 0.1
		await get_tree().create_timer(0.01).timeout
