extends CharacterBody3D

var speed = 5.0
var skip_velocity = 4.5
var rock_power := 0.00
var rock_angle := 0.00
var start_moving := false
var moving_dir_forward := 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	#	velocity += get_gravity() * delta
	#Handle skip.
	#velocity.y = skip_velocity

	if start_moving == true:
		moving_dir_forward = -1
		start_moving = false
	var direction := (transform.basis * Vector3(0, moving_dir_forward, moving_dir_forward)).normalized()
	if direction:
		velocity.x = direction.x * speed * (rock_angle/2)
		velocity.z = direction.z * speed * (rock_power/2)
		velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.x, 0, speed * rock_angle)
		velocity.z = move_toward(velocity.z, 0, speed + rock_power)
	move_and_slide()

func throw(throw_power, throw_angle) -> void:
	rock_power = throw_power
	rock_angle = throw_angle
	start_moving = true
	print("throwing")
