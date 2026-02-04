extends Control

var save_dir : String = "res://"
var save_file_name : String = "skipper.json"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://concept_level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func load_data(path: String, new_game):
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
		printerr("Cannot Open File")
		get_tree().change_scene_to_file("res://char_creation.tscn")


func _on_continue_pressed() -> void:
	load_data(save_dir+save_file_name, false)


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://char_creation.tscn")
