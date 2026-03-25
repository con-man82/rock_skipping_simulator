extends Control

@onready var area: TextEdit = $TextEdit
@onready var density: TextEdit = $TextEdit2
@onready var sArea: TextEdit = $TextEdit3
@onready var set_stats: Button = $set_stats

signal debug_stats(debug_a, debug_d, debug_surf_area)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_concept_rock_rockstats(a: Variant, d: Variant, s_area: Variant) -> void:
	area.placeholder_text = str(a)
	density.placeholder_text = str(d)
	sArea.placeholder_text = str(s_area)
	area.text = str(a)
	density.text = str(d)
	sArea.text = str(s_area)

func _on_set_stats_pressed() -> void:
	debug_stats.emit(area.text, density.text, sArea.text)


func _on_reset_level_pressed() -> void:
	get_tree().change_scene_to_file("res://concept_level.tscn")
