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
var w : float = 2 # w is fundamental frequency, google said 37 for stone. We'll see!
var a : float # = 0.1 # area of rock object
var d : float # = 0.9 # density of rock object

# Calculated at runtime
var n : float # unit vector normal to the stone (perpendicular to t), need to figure this out
var M : float # = a * d
var theta : float = 0.75 * PI
var C : float = cl

#func _init(_M: float, _surface_area: float, ):
func _init(_a: float, _d: float, _surface_area: float):
	#self.M = _M
	self.a = _a
	self.d = _d
	self.M = m(self.a, self.d)
	self.surface_area = _surface_area

func throw(_direction: float, _velocity: float) -> void:
	self.direction = _direction
	self.velocity = _velocity

func m(a: float, d: float):
	return a*d

# CALL THIS ON EVERY COLLISION
func pitty_pat(vx_0: float, vz_0: float, nc: float):
	var delta_x0 : float = 2 * vx_0 * abs( vz_0 ) / G
	return delta_x0 * sqrt(1 - (n / nc))

# CALL THIS ON INITIAL COLLISION?
func num_bounces():	
	return pow(velocity, 2) / (2 * G * u() * l())

# FIGURE OUT RELATIONSHIP
func reaction_force_due_to_water() -> float:
	return (0.5 * cl * PW * pow(velocity, 2) * surface_area * n) + (0.5 * cf * PW * pow(velocity, 2) * surface_area * direction)

# FIGURE OUT RELATIONSHIP
func loss_due_to_kinetic_energy():
	return - u() * self.M * G * l()

# NOT CALLED DIRECTLY
func u():
	return cf / cl

# NOT CALLED DIRECTLY
# theta is incidence angle, angle between surface of the rock and surface of water on collision
func l():
	return 2 * PI * sqrt((w * self.M * sin(theta)) / C * PW * a)

# no y direction on pitty pat? what about the end (hockey stick shaped trajectory)
