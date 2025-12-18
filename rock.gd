extends Node3D


var rockStats := {"rock_model" : "", 
					"power_mod" : "",
					"skip_mod" : "",
					"velocity_mod" : "",
					"initial_powerup" : "",
					"focus_mod" : "",
					"boost_max" : "",
					"boost_current" : "",
					"on_fire" : false,
					"fancy" : false, 
					"froggy" : "",
					"bouyant" : "",
					"fragile": false,
					"lob skip" : "",
					"die_hard" : false,
					"detonate" : false,
					"glide" : false,
					"glide_power" : "",
					"pretty" : false,
					"pretty_power" : "",
					"boomerang" : false,
					"Pet" : false }


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_rock()


func create_rock() -> void:
	rockStats = {"rock_model" : "", 
					"power_mod" : get_a_random_value(0.1,10.0),
					"skip_mod" : get_a_random_value(0.1,10.0),
					"velocity_mod" : get_a_random_value(0.1,10.0),
					"initial_powerup" : "",
					"focus_mod" : get_a_random_value(0.1,10.0),
					"boost_max" : get_a_random_value(0.1,10.0),
					"boost_current" : rockStats["boost_max"],
					"on_fire" : false,
					"fancy" : false, 
					"froggy" : "",
					"bouyant" : "",
					"fragile": false,
					"lob skip" : "",
					"die_hard" : false,
					"detonate" : false,
					"glide" : false,
					"glide_power" : get_a_random_value(0.1,10.0),
					"pretty" : false,
					"pretty_power" : get_a_random_value(0.1,10.0),
					"boomerang" : false,
					"Pet" : false }
	
	printt("Rock = ", rockStats)

func get_a_random_value(betweenThis:float, betweenThat:float) -> float:
	var random_number := randf_range(betweenThis, betweenThat)
	return random_number
