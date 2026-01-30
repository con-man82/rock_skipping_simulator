extends Control

@onready var avatar_path := "res://Assests/Characters/Placeholders/"
@onready var disp_name_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/NameHbox/DispNameLabel
@onready var disp_str_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/StrHbox/DispStrLabel
@onready var disp_dex_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/DexHbox/DispDexLabel
@onready var disp_wil_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/WilHbox/DispWilLabel
@onready var disp_cha_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/ChaHbox/DispChaLabel
@onready var disp_lck_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/LckHbox2/DispLckLabel
@onready var avatar: Sprite2D = $BoxContainer/Panel/Sprite2D

var CharOpt1Stats := {	"character_image" : "14.png", 
						"str" : 0,
						"dex": 0,
						"wil" : 0,
						"cha": 0,
						"luck" : 0,
						"power_name" : "Special Ability"}

var CharOpt2Stats := {	"character_image" : "17.png", 
						"str" : 5,
						"dex": 5,
						"wil" : 5,
						"cha": 5,
						"luck" : 5,
						"power_name" : "Special Ability"}

var CharOpt3Stats := {	"character_image" : "8.png", 
						"str" : 10,
						"dex": 10,
						"wil" : 10,
						"cha": 10,
						"luck" : 10,
						"power_name" : "Special Ability"}

var charOptionsArray := []
var statVarArray := []
var dispStatsArray := []
var currentSelect := 0
var MAX_PLAYER_OPTIONS := 3

func _ready() -> void:
	charOptionsArray = [CharOpt1Stats, CharOpt2Stats, CharOpt3Stats]
	statVarArray = ["str","dex","wil","cha","luck"]
	dispStatsArray = [disp_str_label,disp_dex_label,disp_wil_label,disp_cha_label,disp_lck_label]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range (5):
		dispStatsArray[i].text = str(charOptionsArray[currentSelect][statVarArray[i]])
	avatar.texture = load(avatar_path+charOptionsArray[currentSelect]["character_image"])

func _on_save_pressed() -> void:
	var playerToSaveDict : Dictionary
	playerToSaveDict = charOptionsArray[currentSelect]
	var save_dir : String = "res://"
	var save_file_name : String = "skipper.json"
	print("Character Created = ", playerToSaveDict)
	#var file = FileAccess.open_encrypted_with_pass(save_dir  + save_file_name, FileAccess.WRITE, "secKey")
	var file = FileAccess.open(save_dir + save_file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(playerToSaveDict, "\t")
	file.store_string(json_string)
	file.close()


func _on_create_skip_master_pressed() -> void:
	var playerToSaveDict : Dictionary
	playerToSaveDict = charOptionsArray[currentSelect]
	var save_dir : String = "res://"
	var save_file_name : String = "skipper.json"
	print("Character Created = ", playerToSaveDict)
	#var file = FileAccess.open_encrypted_with_pass(save_dir  + save_file_name, FileAccess.WRITE, "secKey")
	var file = FileAccess.open(save_dir + save_file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(playerToSaveDict, "\t")
	file.store_string(json_string)
	file.close()
	get_tree().change_scene_to_file("res://concept_level.tscn")

func _on_left_select_pressed() -> void:
	currentSelect = currentSelect - 1
	if currentSelect < 0:
		currentSelect = MAX_PLAYER_OPTIONS - 1


func _on_right_select_pressed() -> void:
	currentSelect = currentSelect + 1
	if currentSelect >= MAX_PLAYER_OPTIONS:
		currentSelect = 0
