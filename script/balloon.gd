extends CharacterBody2D
var transition = preload("res://scene/transition.tscn")
var damage = preload("res://scene/damage.tscn")
var health = 110
var end = true

func _ready():
	if Global.game_loaded == false:
		await get_tree().create_timer(2).timeout
	while position.y > -6577:
		await get_tree().process_frame
		var delta = get_process_delta_time()
		position.y -= 120.0 * delta
		Global.balloon_pos = position
		$ProgressBar.value = health
		if health < 1:
			%"Death Screen".visible = true
			Global.death_cause = 1
			print(Global.death_cause)
			$Pop.playing = true
			queue_free()
		if Global.death_cause == 1 or Global.death_cause == 2 or Global.death_cause == -2 or Global.death_cause == -1:
			queue_free()
	await get_tree().create_timer(1).timeout
	end = false
	for i in range(25):
		position = lerp(position, Global.player_pos, 0.1)
		await get_tree().create_timer(0.01).timeout

func _on_area_2d_area_entered(area: Area2D) -> void:
	if end == true:
		health -= 5
		$Hurt.playing = true
		var damamge_clone = damage.instantiate()
		add_child(damamge_clone)
		damamge_clone.position = %Camera2D.position
	else:
		var transitionclone = transition.instantiate()
		get_parent().add_child(transitionclone)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scene/Win_Screen.tscn")
