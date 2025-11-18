extends CharacterBody3D


@onready var rock_area_3d: Area3D = $MeshInstance3D/RockArea3D

var speed = 5.0
var skip_velocity = 10.1
var rock_power := 0.00
var rock_angle := 0.00
var start_moving := false
var moving_dir_forward := 0
var skip_attempt := false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
	velocity += get_gravity() * delta
	print(skip_attempt)
	if skip_attempt == true:
		velocity.y = skip_velocity
		skip_attempt = false

	if start_moving == true:
		moving_dir_forward = -1
		start_moving = false
	var direction := (transform.basis * Vector3(0, moving_dir_forward, moving_dir_forward)).normalized()
	if direction:
		velocity.x = direction.x * speed * (rock_angle/2)
		velocity.z = direction.z * speed * (rock_power/2)
		#velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.x, 0, speed * rock_angle)
		velocity.z = move_toward(velocity.z, 0, speed + rock_power)
	move_and_slide()

func throw(throw_power, throw_angle) -> void:
	rock_power = throw_power
	rock_angle = throw_angle
	start_moving = true
	print("throwing")

#When the rock enters a shape3D this happens fuction happens: (right now the water is a shape3D, so basically when the rocks area is entered by the water shape it will skip)
func _on_rock_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	print("a41 ",str(body))
	skip_attempt = true

func _on_rock_area_3d_body_entered(body: Node3D) -> void:
	print("qwe ",str(body))
	skip_attempt = true

func _on_rock_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	printt("asd ",str(area))
	skip_attempt = true
