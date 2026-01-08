# math bullshit
# Constants
const G : float = 9.8 # gravity, m / s^2
const PW : float = 1000 # mass density of water

# member variables
var direction: float
var velocity: float # velocity object that contains x/y/z
var surface_area: float

# these will all be populated based on level and rock selected
var cf : float = 1 # lift coefficient
var cl : float  = 1 # friction coefficient
var w : float = 1 # i forget what w is
var a : float = 0.1 # area of rock object
var d : float = 0.9 # density of rock object

# Calculated at runtime
var n : float # unit vector normal to the stone (perpendicular to t), need to figure this out
var M : float = a * d
var theta : float = 0.75 * PI
var C : float = cl

func _init(direction: float, velocity: float, surface_area: float) -> void:
	self.direction = direction
	self.velocity = velocity
	self.surface_area = surface_area

# NOT CALLED DIRECTLY
func u():
	return cf / cl

# NOT CALLED DIRECTLY
# theta is incidence angle, angle between surface of the rock and surface of water on collision
func l():
	return 2 * PI * sqrt((w * M * sin(theta)) / C * PW * a)

# CALL THIS ON INITIAL COLLISION?
func num_bounces():	
	return pow(velocity, 2) / (2 * G * u() * l())

# FIGURE OUT RELATIONSHIP
func reaction_force_due_to_water(t) -> float:
	return (0.5 * cl * PW * pow(velocity, 2) * surface_area * n) + (0.5 * cf * PW * pow(velocity, 2) * surface_area * direction)

# FIGURE OUT RELATIONSHIP
func loss_due_to_kinetic_energy():
	return - u() * M * G * l()

# CALL THIS ON EVERY COLLISION
func pitty_pat(vx_0: float, vz_0: float, nc: float):
	var delta_x0 : float = 2 * vx_0 * abs( vz_0 ) / G
	return delta_x0 * sqrt(1 - (n / nc))

# no y direction on pitty pat? what about the end (hockey stick shaped trajectory)