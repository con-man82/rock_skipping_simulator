extends Control

var save_dir : String = "res://"
var save_file_name : String = "skipper.json"
@onready var new_gameButton: Button = $AspectRatioContainer/VBoxContainer/NewGame
@onready var continueButton: Button = $AspectRatioContainer/VBoxContainer/Continue
@onready var menu_sound_enter_button: AudioStreamPlayer = $MenuSoundEnterButton
@onready var menu_sound_exit_button: AudioStreamPlayer = $MenuSoundExitButton
@onready var button_3: AudioStreamPlayer = $Button3
@onready var button_2: AudioStreamPlayer = $Button2
@onready var button_1: AudioStreamPlayer = $Button1




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data(save_dir+save_file_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://concept_level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


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
		#new_gameButton.visible = false
		continueButton.visible = true
	else:
		printerr("Cannot Open File")
		#get_tree().change_scene_to_file("res://char_creation.tscn")

func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://concept_level.tscn")

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://char_creation.tscn")

func _play_menu_enter_sound() -> void:
	menu_sound_enter_button.play()

func _play_menu_exit_sound() -> void:
	menu_sound_exit_button.play()

func _on_new_game_mouse_entered() -> void:
	button_3.play() # Replace with function body.

func _on_continue_mouse_entered() -> void:
	button_2.play()

func _on_quit_mouse_entered() -> void:
	button_1.play()
