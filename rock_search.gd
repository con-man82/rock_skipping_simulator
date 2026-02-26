extends Node3D

@onready var input_delay_timer: Timer = $InputDelayTimer
@onready var label: Label = $NPCTextBox/Panel/VBoxContainer/Label
@onready var search_for_rock: Button = $SearchButtonBox/SearchForRock
@onready var start_skipping: Button = $SearchButtonBox/StartSkipping
@onready var npc_text_box: Control = $NPCTextBox


var save_dir : String = "res://"
var save_file_name : String = "skipper.json"
var character := {}
var first_time := false
var npc_text := []
var accept_input := true
var searching := false

var intro_txt_prog := 0
var delay_wait := 0.2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	npc_text_box.visible = false
	load_data(save_dir+save_file_name) # Replace with function body.
	if "rocks" in character:
		first_time = false
	else:
		character["rocks"] = []
		print(str(character))
		first_time = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if first_time == false and searching == false:
		chat_with_NPC()
	elif searching == false:
		intro()
	else:
		pass

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
		else:
			character = data
			print(str(character))
	else:
		printerr("Cannot Open File")
		#get_tree().change_scene_to_file("res://char_creation.tscn")
		
func intro()->void:
	npc_text_box.visible = true
	npc_text =["Hey Skip Master!", "I'm Gem!\nNice to meet you!", "What?!\n You don't have any rocks???", "Me either actually.", "Just press that button to search!"]
	label.text = npc_text[intro_txt_prog]
	if Input.is_action_just_released("power_hit") and accept_input == true:
		intro_txt_prog += 1
		if intro_txt_prog >= npc_text.size():
			printt(intro_txt_prog, npc_text.size())
			search_for_rock.visible = true
			npc_text_box.visible = false
			intro_txt_prog = 0
			first_time = false
		delay_input()

func chat_with_NPC()->void:
	npc_text_box.visible = true
	npc_text =["What's up "+character["name"]+"?!", "If you need more rocks\njust press that button to search!"]
	label.text = npc_text[intro_txt_prog]
	if Input.is_action_just_released("power_hit") and accept_input == true:
		intro_txt_prog += 1
		if intro_txt_prog >= npc_text.size():
			printt(intro_txt_prog, npc_text.size())
			search_for_rock.visible = true
			npc_text_box.visible = false
			intro_txt_prog = 0
			searching = true
		delay_input()


func delay_input() -> void:
	if accept_input == true:
		input_delay_timer.start(delay_wait)
		accept_input = false
	
func _on_input_delay_timer_timeout() -> void:
	accept_input = true

func _on_button_pressed() -> void:
	searching = true
	search_for_rock.visible = false
	npc_text_box.visible = true
	npc_text = ["Wow, you found a rock!\nGo and see how far you can skip it!", "Oh Cool, that's a pretty rad rock!\nGo and see how far you can skip it!", "Did you just find a crusty hamburger bun??\nGo and see how far you can skip it!"]
	label.text = npc_text[randi_range(0,npc_text.size()-1)]
	find_rock()
	print (str(character))
	start_skipping.visible = true
		

func _on_start_skipping_pressed() -> void:
	_on_save_pressed()
	get_tree().change_scene_to_file("res://concept_level.tscn")

func find_rock()->void:
	character["rocks"].append({"type": "Test"}) 
	
func _on_save_pressed() -> void:
	var playerToSaveDict : Dictionary
	playerToSaveDict = character
	var save_dir : String = "res://"
	var save_file_name : String = "skipper.json"
	print("Character saved = ", playerToSaveDict)
	#var file = FileAccess.open_encrypted_with_pass(save_dir  + save_file_name, FileAccess.WRITE, "secKey")
	var file = FileAccess.open(save_dir + save_file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(playerToSaveDict, "\t")
	file.store_string(json_string)
	file.close()
