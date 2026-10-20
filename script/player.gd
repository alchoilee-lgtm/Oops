extends CharacterBody2D

var particles = preload("res://scene/player_jump.tscn")
var shoot_particles = preload("res://scene/player_shoot.tscn")
var bullet = preload("res://scene/bullet.tscn")
var ammo_amount = 10

@onready var coyote_time = $"Coyote Time"

const SPEED = 450
const JUMP_VELOCITY = -1000

func _ready():
	Global.death_cause = 0
	Global.camera_pos.y = 100000

func _process(delta: float): 
	Global.player_pos = global_position
	if Input.is_action_just_pressed("click") and ammo_amount > 0:
		$Shoot.playing = true
		var new_bullet = bullet.instantiate()
		get_parent().add_child(new_bullet)
		new_bullet.position = global_position
		new_bullet.look_at(get_global_mouse_position())
		var particles_shoot = shoot_particles.instantiate()
		get_parent().add_child(particles_shoot)
		particles_shoot.rotation = rotation
		ammo_amount -= 1
	$ProgressBar.value = ammo_amount
	if position.y > Global.camera_pos.y + 70:
		%"Death Screen".visible = true
		Global.death_cause = 2
		print(Global.death_cause)
		queue_free()
	if Global.death_cause == 1 or Global.death_cause == 2 or Global.death_cause == -2 or Global.death_cause == -1:
			queue_free()

func _physics_process(delta: float) -> void:
	var was_on_floor = is_on_floor()
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and (is_on_floor() or !coyote_time.is_stopped()):
		var particles_jump = particles.instantiate()
		get_parent().add_child(particles_jump)
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	var left_right = direction * 90
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if left_right == -90 and is_on_floor():
		$AnimatedSprite2D.animation = "Left"
	elif left_right == 90 and is_on_floor():
		$AnimatedSprite2D.animation = "Right"
	elif left_right == -90 and not is_on_floor():
		$AnimatedSprite2D.animation = "Jump_Left"
	elif left_right == 90 and not is_on_floor():
		$AnimatedSprite2D.animation = "Jump_Right"
	elif is_on_floor() and left_right == 0:
		$AnimatedSprite2D.animation = "Right"
	elif not is_on_floor() and left_right == 0:
		$AnimatedSprite2D.animation = "Jump_Right"
	move_and_slide()
	
	
	if was_on_floor && not is_on_floor() and velocity.y >= 0:
		coyote_time.start()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if ammo_amount < 10:
		ammo_amount += 1
