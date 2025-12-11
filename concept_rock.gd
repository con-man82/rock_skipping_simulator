extends CharacterBody3D

#add spinning
#add drag - accel on bounce
#change or randomize rocks

@onready var rock_area_3d: Area3D = $MeshInstance3D/RockArea3D
@onready var rock_mesh: MeshInstance3D = $Rock
@onready var rock_cam_top: Camera3D = $RockCamTop

const ROCK_1 = preload("uid://nw4bx6304nlc")
const ROCK_3 = preload("uid://rssf13emrj8r")
const ROCK_4 = preload("uid://cp6j4lq0t7shj")
const ROCK_5 = preload("uid://dqnw05upv70sj")
const ROCK_6 = preload("uid://br7q5m2wwtpfw")
const ROCK_7 = preload("uid://bctq60oe8vry")

var speed = 5.0
var dragging_speed := 0.0
var skip_velocity = 10.1
var rock_power := 0.00
var rock_spin := 0.00
var start_moving := false
var moving_dir_forward := 0
var skip_attempt := false
var stop_rock = false
var rock_path = "Assests/Rocks/"

signal skip_signal()
signal start_throw()
signal rock_stop()

var testing := true

func _ready() -> void:
	#pass#rock_mesh.mesh=ROCK_7

	if testing == false:
		var num = select_random_rock()
		print(num)
		var rock = rock_path + "rock" + str(num) + "/" + "rock" + str(num) + ".obj"
		rock_mesh.mesh = load(rock)
		#rock_mesh.material_overlay = load(rock_path + "rock" + str(num) + "/" + "texture.*")

		#I was messing around and trying to get the texture to load correctly,
			#But ran out of time to keep messing around with it 12/9/25
		#var rock_material = StandardMaterial3D.new()
		#rock_material.mesh = load(rock)
		#rock_material.albedo_texture = load(rock_path + "rock" + str(num) + "/" + "texture.*")
		#rock_mesh.mesh.surface_set_material(0, rock_material) 
		#rock_mesh.mesh = rock_material
		#rock_mesh.material_overlay.albedo_texture = load(rock_texture)


func _physics_process(delta: float) -> void:

	
	#print(skip_attempt)
	if skip_attempt == true:
		if skip_velocity > dragging_speed:
			velocity.y = skip_velocity - dragging_speed
			skip_velocity -= 1.5
			dragging_speed += 1  
			# add skip counter increase here
		else:
			pass 
		skip_attempt = false
		

	if start_moving == true:
		moving_dir_forward = -1
		start_moving = false
	var direction := (transform.basis * Vector3(0, moving_dir_forward, moving_dir_forward)).normalized()
	if stop_rock == false:
		#gravity
		velocity += get_gravity() * delta
		if direction:
			var current_speed = speed - dragging_speed
			var current_rotate = current_speed 
			if current_rotate > 0:
				rock_mesh.rotation.y += (rock_spin) #- current_rotate)
			else:
				rock_mesh.rotation.y = 0
			if current_speed <= 0:
				current_speed = 0
				rock_stop.emit()
			velocity.x = direction.x * current_speed * (rock_power/2)
			velocity.z = direction.z * current_speed * (rock_power/2)
			#velocity.y = direction.y * speed
		else:
			velocity.y = move_toward(0, 0, speed * rock_spin)
			velocity.z = move_toward(velocity.z, 0, speed + rock_power)
		move_and_slide()

func throw(throw_power, throw_spin) -> void:
	rock_power = throw_power
	rock_spin = throw_spin
	start_moving = true
	start_throw.emit()
	print("throwing")


#When the rock enters a shape3D this happens fuction happens: (right now the water is a shape3D, so basically when the rocks area is entered by the water shape it will skip)
#func _on_rock_area_3d_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
#	print("a41 ",str(body))
#	skip_attempt = true


#func _on_rock_area_3d_body_entered(body: Node3D) -> void:
#	print("qwe ",str(body))
#	skip_attempt = true


func _on_rock_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	printt("asd ",str(area))
	if area.is_in_group("Floor"):
		stop_rock = true
		rock_stop.emit() #need to move somewhere for when the rock stops moving forward
	else:
		skip_attempt = true
		skip_signal.emit()
	printt(str(area))
	print("Stop_rock = ", stop_rock)


#Connor: "OK, I figured out where time comes from!"

func select_random_rock():
	var dir = DirAccess.open(rock_path)
	var available_rock_dirs = dir.get_directories()
	
	var acceptable_rocks = []
	
	for rock in available_rock_dirs:
		var rock_sub_dir = DirAccess.open(rock_path + "/" + rock)
		print(rock_sub_dir)
		var files = rock_sub_dir.get_files()

		if files.find(".obj") && (files.find(".jpg") || files.find(".png")):
			acceptable_rocks.append(str(rock_sub_dir))
				
	print("acceptable rocks: " + str(acceptable_rocks.size()))

	return randi_range(0, acceptable_rocks.size())
