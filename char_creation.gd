extends Control

@onready var avatar_path := "res://Assests/Characters/Placeholders/"
@onready var disp_name_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/NameHbox/DispNameLabel
@onready var disp_str_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/StrHbox/DispStrLabel
@onready var disp_dex_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/DexHbox/DispDexLabel
@onready var disp_wil_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/WilHbox/DispWilLabel
@onready var disp_cha_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/ChaHbox/DispChaLabel
@onready var disp_lck_label: Label = $BoxContainer/Panel/VBoxContainer/HBoxContainer/VBoxContainer/LckHbox2/DispLckLabel
@onready var avatar: Sprite2D = $BoxContainer/Panel/Sprite2D
@onready var h_box_container: HBoxContainer = $BoxContainer/Panel/VBoxContainer/HBoxContainer
@onready var change_name_box_container: BoxContainer = $ChangeNameBoxContainer
@onready var line_edit: LineEdit = $ChangeNameBoxContainer/HBoxContainer/LineEdit
@onready var points_left_label: Label = $BoxContainer/Panel/StatPointsToDistributeHbox/PointsLeftLabel



var CharOpt1Stats := {	"character_image" : "14.png", 
						"pow" : 0,
						"spin": 0,
						"acc" : 0,
						"pre": 0,
						"luck" : 0,
						"power_name" : "Special Ability"}

var CharOpt2Stats := {	"character_image" : "17.png", 
						"pow" : 5,
						"spin": 5,
						"acc" : 5,
						"pre": 5,
						"luck" : 5,
						"power_name" : "Special Ability"}

var CharOpt3Stats := {	"character_image" : "8.png", 
						"pow" : 10,
						"spin": 10,
						"acc" : 10,
						"pre": 10,
						"luck" : 10,
						"power_name" : "Special Ability"}

var charOptionsArray := []
var statVarArray := []
var dispStatsArray := []
var currentSelect := 0
var MAX_PLAYER_OPTIONS := 3
var playerName := "Skip"
var MAX_POINTS_TO_SPEND := 25
var currentPointsToUse := 0

func _ready() -> void:
	charOptionsArray = [CharOpt1Stats, CharOpt2Stats, CharOpt3Stats]
	statVarArray = ["pow","spin","acc","pre","luck"]
	dispStatsArray = [disp_str_label,disp_dex_label,disp_wil_label,disp_cha_label,disp_lck_label]
	currentPointsToUse = MAX_POINTS_TO_SPEND
	
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
	playerToSaveDict["name"] = playerName
	playerToSaveDict["Inventory"] = []
	playerToSaveDict["Money"] = 1.01
	playerToSaveDict["BucketSize"] = 3
	var save_dir : String = "res://"
	var save_file_name : String = "skipper.json"
	print("Character Created = ", playerToSaveDict)
	#var file = FileAccess.open_encrypted_with_pass(save_dir  + save_file_name, FileAccess.WRITE, "secKey")
	var file = FileAccess.open(save_dir + save_file_name, FileAccess.WRITE)
	var json_string = JSON.stringify(playerToSaveDict, "\t")
	file.store_string(json_string)
	file.close()
	get_tree().change_scene_to_file("res://rock_search.tscn")


func _on_left_select_pressed() -> void:
	currentSelect = currentSelect - 1
	if currentSelect < 0:
		currentSelect = MAX_PLAYER_OPTIONS - 1


func _on_right_select_pressed() -> void:
	currentSelect = currentSelect + 1
	if currentSelect >= MAX_PLAYER_OPTIONS:
		currentSelect = 0


func _on_chg_name_button_pressed() -> void:
	h_box_container.visible = false
	change_name_box_container.visible = true
	

func _on_change_name_ok_pressed() -> void:
	playerName = line_edit.text
	disp_name_label.text = playerName
	h_box_container.visible = true
	change_name_box_container.visible = false


func lower_current_distrib_points(stat : String) -> void:
	if currentPointsToUse > 0:
		currentPointsToUse = currentPointsToUse - 1
		charOptionsArray[currentSelect][stat] += 1
	else:
		currentPointsToUse = 0
	points_left_label.text = str(currentPointsToUse)

func raise_current_distrib_points(stat : String) -> void:
	if currentPointsToUse < MAX_POINTS_TO_SPEND:
		currentPointsToUse = currentPointsToUse + 1
		charOptionsArray[currentSelect][stat] -= 1
	else:
		currentPointsToUse = MAX_POINTS_TO_SPEND
	points_left_label.text = str(currentPointsToUse)
		
func _on_pow_down_pressed() -> void:
	raise_current_distrib_points("pow")
	
func _on_pow_up_pressed() -> void:
	lower_current_distrib_points("pow")

func _on_spin_down_pressed() -> void:
	raise_current_distrib_points("spin")

func _on_spin_up_pressed() -> void:
	lower_current_distrib_points("spin")

func _on_acc_down_pressed() -> void:
	raise_current_distrib_points("acc")

func _on_acc_up_pressed() -> void:
	lower_current_distrib_points("acc")

func _on_pre_down_pressed() -> void:
	raise_current_distrib_points("pre")

func _on_pre_up_pressed() -> void:
	lower_current_distrib_points("pre")

func _on_luck_down_pressed() -> void:
	raise_current_distrib_points("luck")

func _on_luck_up_pressed() -> void:
	lower_current_distrib_points("luck")
