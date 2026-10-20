extends Node2D

const transition_out = preload("res://scene/transition_out.tscn")

func _ready():
	await get_tree().create_timer(0.1).timeout
	var transitionclone = transition_out.instantiate()
	get_parent().add_child(transitionclone)
	$WinScreen.modulate.a = 1
	$WinScreen2.modulate.a = 1
	$Fade.modulate.a = 0

func _on_one_timeout() -> void:
	for i in range(10):
		$WinScreen.modulate.a -= 0.1
		await get_tree().create_timer(0.01).timeout

func _on_two_timeout() -> void:
	await get_tree().create_timer(1.5).timeout
	for i in range(20):
		$Fade.modulate.a += 0.05
		await get_tree().create_timer(0.01).timeout
