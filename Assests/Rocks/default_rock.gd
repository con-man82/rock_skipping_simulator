extends Resource
class_name Rock

var rockStats := {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_rock()

#sets up rocks starting stats
func create_rock() -> void:
	rockStats = {"rock_model" : "", 
					"rock_area" : get_a_random_value(0.1,10.0), #.8 seems like a good default, but random for testing
					"rock_density" : 2.8, #2.8 seems really good
					"surface_area" : get_a_random_value(100, 5000), #1000 seems good
					"power_mod" : get_a_random_value(0.1,10.0),
					"skip_mod" : get_a_random_value(0.1,10.0),
					"velocity_mod" : get_a_random_value(0.1,10.0),
					"initial_powerup" : "",
					"focus_mod" : get_a_random_value(0.1,10.0),
					"boost_max" : get_a_random_value(0.1,10.0),
					#"boost_current" : rockStats["boost_max"],
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


#I think the idea for this fuction is for the ability to upgrade a rock's modifiers later 
#since you can just do rock.fuction(value, then top end of the the mod) to gamble on stat 
#increases? but to be honest I can't remember why I did this
func get_a_random_value(betweenThis:float, betweenThat:float) -> float:
	var random_number := randf_range(betweenThis, betweenThat)
	return random_number
