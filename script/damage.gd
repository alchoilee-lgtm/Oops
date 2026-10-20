extends MeshInstance2D


func _ready():
	modulate.a = 0.5
	for t in range(5):
		modulate.a -= 0.1
		await get_tree().create_timer(0.02).timeout
	queue_free()
