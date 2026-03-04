extends CharacterBody3D


@onready var rock_area_3d: Area3D = $MeshInstance3D/RockArea3D
@onready var rock_mesh: MeshInstance3D = $Rock
@onready var rock_cam_top: Camera3D = $RockCamTop
@onready var gpu_particles_3d: GPUParticles3D = $Rock/GPUParticles3D

const waterRipple: PackedScene = preload("res://Assests/Particles/rock_water_splash_gpu_particles_3d.tscn")

const ROCK_1 = preload("uid://nw4bx6304nlc")
const ROCK_3 = preload("uid://rssf13emrj8r")
const ROCK_4 = preload("uid://cp6j4lq0t7shj")
const ROCK_5 = preload("uid://dqnw05upv70sj")
const ROCK_6 = preload("uid://br7q5m2wwtpfw")
const ROCK_7 = preload("uid://bctq60oe8vry")


const RockPhysics = preload("res://rock_physics.gd") 

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
var num_bounces = 0

#var physics = RockPhysics.new(3, 2.8, 10) starting stats before 3/1
var physics = RockPhysics.new(.8, 2.8, 1000) #messing with numbers on 3/1
#a area of rock object var# 1 in rock physics
#d density of rock object var# 2 in rock physics 
var dragon_speed : float
var reaction_force : float

signal skip_signal()
signal start_throw()
signal rock_stop()

var testing := true

func _ready() -> void:
	#pass#rock_mesh.mesh=ROCK_7
	#spawn_splash()
	print(skip_velocity)

	dragon_speed = abs(physics.loss_due_to_kinetic_energy()) / 3000
	# dragon_speed = abs(reaction_force) / 2000
	print("Loss from KE: " + str(dragon_speed))
	

	if testing == false:
		var num = select_random_rock()
		print("rock num: " + str(num))
		var rock = rock_path + "rock" + str(num) + "/" + "rock" + str(num) + ".obj"
		rock_mesh.mesh = load(rock)
		#rock_mesh.material_overlay = load(rock_path + "rock" + str(num) + "/" + "texture.*")

		#I was messing around and trying to get the texture to load correctly,
			#But ran out of time to keep messing around with it 12/9/25
		# 12/17/2025 I think it has something to do with the texture being manually added to the mesh? will test more later
		#var rock_material = StandardMaterial3D.new()
		#rock_material.mesh = load(rock)
		#rock_material.albedo_texture = load(rock_path + "rock" + str(num) + "/" + "texture.*")
		#rock_mesh.mesh.surface_set_material(0, rock_material) 
		#rock_mesh.mesh = rock_material
		#rock_mesh.material_overlay.albedo_texture = load(rock_texture)


func _physics_process(delta: float) -> void:
	
	if skip_attempt == true:
		if skip_velocity > 0:
			printt("SV = ", skip_velocity)
			velocity.y = skip_velocity / 7 			#this is where the rock height for each skip is
			#gpu_particles_3d.restart() # = true #not working like i think it should, probably need to instance the particle effect? 
		else:
			pass 
		skip_attempt = false


	if start_moving == true:
		moving_dir_forward = -1
		start_moving = false
	var direction := (transform.basis * Vector3(0, moving_dir_forward, moving_dir_forward)).normalized()
	if stop_rock == false:
		#gravity, very important!!!
		velocity += get_gravity() * delta
		if not direction:
			velocity.y = move_toward(0, 0, speed * rock_spin)
			velocity.z = move_toward(velocity.z, 0, speed + rock_power)
			physics.throw(direction.y, velocity.y)
		else:
			var current_speed = speed - dragging_speed
			var current_rotate = rock_spin
			if current_rotate > 0:
				rock_mesh.rotation.y += (rock_spin) #- current_rotate)
			velocity.x = direction.x * current_speed * (rock_power/2)
			velocity.z = direction.z * current_speed * (rock_power/2)
		move_and_slide()

# func throw(throw_power, throw_spin, throw_angle) -> void:
func throw(throw_power, throw_spin) -> void:
	rock_power = throw_power
	rock_spin = throw_spin
	# rock_angle = throw_angle

	skip_velocity = throw_power
	
	printt("Initial SV = ", skip_velocity)

	# print("throw angle: ", throw_angle)
	# physics.throw(throw_power, throw_angle)

	# reaction_force = physics.loss_due_to_kinetic_energy()
	# print("loss: ", reaction_force)
	
	start_moving = true
	start_throw.emit()
	print("throwing")


#When the rock enters a shape3D this happens fuction happens: (right now the water is a shape3D, so basically when the rocks area is entered by the water shape it will skip)
func _on_rock_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Floor"):
		stop_rock = true
		rock_stop.emit() #need to move somewhere for when the rock stops moving forward
	else:
		skip_attempt = true
		skip_velocity = skip_velocity - dragon_speed
		print("I'm entered. Speed should be: " + str(skip_velocity))
		skip_signal.emit()
		spawn_splash()
	print("Stop_rock = ", stop_rock)


#Connor: "OK, I figured out where time comes from!"

func select_random_rock():
	var dir = DirAccess.open(rock_path)
	var available_rock_dirs = dir.get_directories()
	
	var acceptable_rocks = []
	
	for rock in available_rock_dirs:
		var rock_sub_dir = DirAccess.open(rock_path + "/" + rock)
		print("rock_sub_dir: " + str(rock_sub_dir))
		var files = rock_sub_dir.get_files()

		if files.find(".obj") && (files.find(".jpg") || files.find(".png")):
			acceptable_rocks.append(str(rock_sub_dir))
				
	print("acceptable rocks: " + str(acceptable_rocks.size()))

	return randi_range(0, acceptable_rocks.size())

func spawn_splash() -> void:
	var instance = waterRipple.instantiate()
	#instance.global_position = rock_mesh.global_position
	add_child(instance)
