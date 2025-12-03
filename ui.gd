extends Control

@onready var boune_counter: Label = $Control/BouneCounter
@onready var bottom_text: Label = $Control/BottomText
@onready var score: Label = $Control/Score

var bounce_count := 0
var score_count := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boune_counter.text = "Bounce Counter: " + str(bounce_count) # Replace with function body.
	score.text = "Score: " + str(score_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_concept_rock_skip_signal() -> void:
	bounce_count += 1 
	boune_counter.text = "Bounce Counter: " + str(bounce_count)
	score_count += 1 * 1000
	score.text = "Score: " + str(score_count)
