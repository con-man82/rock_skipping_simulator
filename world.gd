extends Node3D

@onready var concept_rock: CharacterBody3D = $ConceptRock
@onready var input_delay_timer: Timer = $InputDelayTimer
@onready var spin_amount_label: Label = $UI/Control/VBoxContainer/AngleHBoxContainer/AngleAmountLabel
@onready var power_amount_label: Label = $UI/Control/VBoxContainer/PowerHBoxContainer/PowerAmountLabel
@onready var bottom_text: Label = $UI/Control/BottomText
@onready var ui: Control = $UI
@export var slider_speed := 100
@export var delay_wait := 0.5
@export var test_power := 100.1
var accept_input := true
var slideNumber := 0.00 
var totalDelta := 0.00
var power := 0.00
var spin := 0.00
var start_action: = false
var reset_slide := false
var slide_up := true
var power_set := false
var spin_set := false
var rock_x_rotation_set := false

var save_dir : String = "res://"
var save_file_name : String = "skipper.json"
var thePlayer := {}

#What is a comment? A miserable little pile of secrets. But enough talk… Have at you!
func _ready() -> void:
	power_amount_label.text = "0"
	spin_amount_label.text = "0"
	load_data(save_dir+save_file_name)
	print(thePlayer)

func _process(delta: float) -> void:     
	#print(accept_input)
	if Input.is_action_just_released("power_hit") and accept_input == true and start_action == false:
		start_action = true
		delay_input()
	if start_action == true and power_set == false and accept_input == true:
		get_power(delta)
	if start_action == true and power_set == true and spin_set == false and accept_input == true:
		get_angle(delta)
	if start_action == true and power_set == true and spin_set == true and accept_input == true:
		get_x_rotation(delta)
	
	if Input.is_action_just_released("restart"):
		get_tree().change_scene_to_file("res://start_screen.tscn")
	
	if reset_slide == true:
		slideNumber = 0
	
	if power_set == true and spin_set == true and rock_x_rotation_set == true and start_action == true:
		concept_rock.throw(power, spin)
		concept_rock.rock_cam_top.current = true     #commented out top down camera for testing 3/2/26
		start_action = false
		

func get_power(delta):
	#print(slideNumber)
	power_amount_label.text = str(int(slideNumber))
	slide_up = slider_direction(slide_up)
	sliding_numbers(delta, slide_up)
	if Input.is_action_just_released("power_hit") and accept_input == true:
		power = slideNumber # put back when not using var test_power
		
		#power = test_power 						#for testing power
		power_amount_label.text = str(power)
		power_set = true
		delay_input()

func get_x_rotation(delta):
	var slow_down := 20
	if slideNumber > 6:
		slideNumber = 0
	#print(str(slideNumber))
	concept_rock.rock_mesh.rotation.x = (slideNumber/10)
	#print(str(concept_rock.rock_mesh.rotation.x))
	slide_up = slider_direction(slide_up, 1) #1 tells slideNumber to only go as high as 30 instead of 100
	sliding_numbers(delta/slow_down, slide_up)
	if Input.is_action_just_released("power_hit") and accept_input == true:
		#concept_rock.rock_mesh.rotation.x = slideNumber commented out on 3/1/26 for testing, the rotation isn't working right, i'll check back in on this later
		#power_amount_label.text = str(power)
		rock_x_rotation_set = true
		delay_input()

func get_angle(delta):
	#print(slideNumber)
	spin_amount_label.text = str(int(slideNumber))
	slide_up = slider_direction(slide_up)
	sliding_numbers(delta, slide_up)
	if Input.is_action_just_released("power_hit") and accept_input == true:
		spin = slideNumber
		spin_amount_label.text = str(spin)
		spin_set = true
		delay_input()


func slider_direction(slide_up_value, do_a_rotate:=0) -> bool:
	if do_a_rotate == 0 and slideNumber < 0:
		return true
	elif do_a_rotate == 1 and slideNumber > 5:
		return false
	elif do_a_rotate == 1 and slideNumber < -3:
		return true
	elif slideNumber > 100:
		return false
	else:
		return slide_up_value


func sliding_numbers(delta, slide_up_value) -> void:
	if slide_up_value == true:
		slideNumber = slideNumber + (delta*slider_speed)
	else:
		slideNumber = slideNumber + -(delta*slider_speed)
		
func sliding_rotate(delta, slide_up_value) -> void:
	if slide_up_value == true:
		slideNumber = slideNumber + (delta*slider_speed)
	else:
		slideNumber = slideNumber + -(delta*slider_speed)

func delay_input() -> void:
	if accept_input == true:
		input_delay_timer.start(delay_wait)
		accept_input = false
	
func _on_input_delay_timer_timeout() -> void:
	accept_input = true
	
func load_data(path: String):
	if FileAccess.file_exists(path):
		#var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, "secKey")
		var file = FileAccess.open(path, FileAccess.READ)
		if file == null:
			print(FileAccess.get_open_error())
			return
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("cannot parse %s as json")
			return
		thePlayer = data
	else:
		printerr("Cannot Open File")
		get_tree().change_scene_to_file("res://char_creation.tscn")
