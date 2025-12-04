extends Control

@onready var boune_counter: Label = $Control/BouneCounter
@onready var bottom_text: Label = $Control/BottomText
@onready var score: Label = $Control/Score

var bounce_count := 0
var score_count := 0
var rock_is_moving := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boune_counter.text = "Bounce Counter: " + str(bounce_count) # Replace with function body.
	score.text = "Score: " + str(score_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if rock_is_moving == true:
		score_up(1, 1) #magic numbers!


func _on_concept_rock_skip_signal() -> void:
	bounce_count += 1 
	boune_counter.text = "Bounce Counter: " + str(bounce_count)


func score_up(count_up, multi):
	score_count = score_count + (count_up * multi)
	update_score_text(score_count)
	
func _on_concept_rock_start_throw() -> void:
	rock_is_moving = true
	
	
func _on_concept_rock_rock_stop() -> void:
	rock_is_moving = false
	if bounce_count > 0:
		score_up(score_count, bounce_count)
		update_score_text(score_count)
		bounce_count = 0
	
func update_score_text(current_score) -> void:
	score.text = "Score: " + str(current_score)
	#maybe add some extra graphics or effects or whatever in here if the score gets really high?
