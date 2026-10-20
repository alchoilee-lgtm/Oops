extends Node2D

func _ready():
	$GPUParticles2D.emitting = true
	global_position = Global.player_pos
