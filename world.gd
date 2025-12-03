extends Node3D
@onready var concept_rock: CharacterBody3D = $ConceptRock
@onready var input_delay_timer: Timer = $InputDelayTimer
@onready var angle_amount_label: Label = $UI/Control/VBoxContainer/AngleHBoxContainer/AngleAmountLabel
@onready var power_amount_label: Label = $UI/Control/VBoxContainer/PowerHBoxContainer/PowerAmountLabel
@onready var bottom_text: Label = $UI/Control/BottomText
@onready var ui: Control = $UI
@export var slider_speed := 100
@export var delay_wait := 0.5
var accept_input := true
var slideNumber := 0.00 
var totalDelta := 0.00
var power := 0.00
var angle := 0.00
var start_action: = false
var reset_slide := false
var slide_up := true

#What is a comment? A miserable little pile of secrets. But enough talk… Have at you!
func _ready() -> void:
	power_amount_label.text = "0"
	angle_amount_label.text = "0"

func _process(delta: float) -> void:     
	#print(accept_input)
	if Input.is_action_just_released("power_hit") and accept_input == true and start_action == false:
		start_action = true
		delay_input()
	if start_action == true and power == 0 and accept_input == true:
		get_power(delta)
	if start_action == true and power > 0 and accept_input == true:
		get_angle(delta)
		
	if Input.is_action_just_released("restart"):
		get_tree().change_scene_to_file("res://start_screen.tscn")
	
	
	if reset_slide == true:
		slideNumber = 0
	
	if power > 0 and angle > 0 and start_action == true:
		concept_rock.throw(power, angle)
		concept_rock.rock_cam_top.current = true
		start_action = false


func get_power(delta):
	#print(slideNumber)
	power_amount_label.text = str(int(slideNumber))
	slide_up = slider_direction(slide_up)
	sliding_numbers(delta, slide_up)
	if Input.is_action_just_released("power_hit") and accept_input == true:
		power = slideNumber
		power_amount_label.text = str(power)
		delay_input()



func get_angle(delta):
	#print(slideNumber)
	angle_amount_label.text = str(int(slideNumber))
	slide_up = slider_direction(slide_up)
	sliding_numbers(delta, slide_up)
	if Input.is_action_just_released("power_hit") and accept_input == true:
		angle = slideNumber
		angle_amount_label.text = str(angle)
		delay_input()


func slider_direction(slide_up_value) -> bool:
	if slideNumber < 0:
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

func delay_input() -> void:
	if accept_input == true:
		input_delay_timer.start(delay_wait)
		accept_input = false
	
func _on_input_delay_timer_timeout() -> void:
	accept_input = true
	
