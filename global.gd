extends Node

var ScoreP1 = 0
var ScoreP2 = 0


var x = 0; var y = 0
var bandera = 1; 
var axis = true; # true = eje X; false = eje Y 
const VELOCITY_BASE = 3
var velocity = VELOCITY_BASE;


func move_background(delta, texture_rect):
	if (Global.axis):
		Global.x += delta/10 * Global.velocity * Global.bandera
		if(Global.x > 1 or Global.x < 0):
			Global.axis = !Global.axis
			Global.x = 1 if Global.x > 1 else 0
	else:
		Global.y += delta/10 * Global.velocity * Global.bandera
		if (Global.y > 1 or Global.y < 0):
			Global.bandera *= -1
			Global.axis = !Global.axis
			Global.y = 1 if Global.y > 1 else 0

	texture_rect.texture.set_fill_from(Vector2(Global.x, 1 - Global.y))
	texture_rect.texture.set_fill_to(Vector2(1 - Global.x, Global.y))

