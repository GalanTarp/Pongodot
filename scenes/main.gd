extends Node

const SPEED = 50
@warning_ignore("integer_division")
const FRICTION = SPEED/4
const xP1 = 20
const xP2 = 1130
var reset := false
var pause:= false

func _ready():
	$PunchAudio.volume_db = linear_to_db(MusicController.volume)
	$WhooshAudio.volume_db = linear_to_db(MusicController.volume)
	Global.ScoreP1 = 0
	Global.ScoreP2 = 0
	Global.ScoreCop = 0

	if(Global.Cooperative):
		$ScoreP1.visible = false
		$ScoreP2.visible = false
		$ScoreCop.visible = true

	#Set parameters to particles of player2 
	var particle = $Player2.find_child("CPUParticles2D")
	particle.direction.x = -1
	particle.gravity.x = -400
	particle.position.x = -particle.position.x

	#Sound of botons
	var botones = get_tree().get_nodes_in_group("boton")
	for boton in botones:
		boton.mouse_entered.connect(on_hover_button)

func _process(delta):
	Global.move_background(delta, $TextureRect)


func _physics_process(_delta):
	if(pause):
		return
	
	$ProgressBar.value = $TimerSpeedBall.time_left
	var velocityP1 = $Player.velocity.y
	var velocityP2 = $Player2.velocity.y
	if Input.is_action_pressed("upP1"):
		if(velocityP1 > -SPEED*10):
			$Player.velocity.y -= SPEED
	if Input.is_action_pressed("downP1"):
		if(velocityP1 < SPEED*10):
			$Player.velocity.y += SPEED
	if Input.is_action_pressed("upP2"):
		if(velocityP2 > -SPEED*10):
			$Player2.velocity.y -= SPEED
	if Input.is_action_pressed("downP2"):
		if(velocityP2 < SPEED*10):
			$Player2.velocity.y += SPEED
	
	#Reset velocity in x
	$Player.velocity.x = 0
	$Player2.velocity.x = 0
	
	var pP1 = $Player.position.y
	var pP2 = $Player2.position.y
	$Player.transform = Transform2D(0, Vector2(xP1, pP1))
	$Player2.transform = Transform2D(0, Vector2(xP2, pP2))
	
	#Create friction when its not pressed
	if(velocityP1 != 0):
		if (abs(velocityP1) < FRICTION):
			$Player.velocity.y = 0
		else:
			$Player.velocity.y += FRICTION if velocityP1 < 0 else -FRICTION
	if(velocityP2 != 0):
		if (abs(velocityP2) < FRICTION):
			$Player2.velocity.y = 0
		else:
			$Player2.velocity.y += FRICTION if velocityP2 < 0 else -FRICTION
	
	$Player.move_and_slide()
	$Player2.move_and_slide()


func _on_ball_body_entered(body):
	if body.is_in_group("player"):
		$Ball.direction *= -1
		$PunchAudio.play()
		if(Global.Cooperative):
			Global.ScoreCop += 1
			$ScoreCop.text = str(Global.ScoreCop)
		if(body.name == "Player"):
			var particle = $Player.find_child("CPUParticles2D")
			particle.global_position.y = $Ball.global_position.y
			particle.emitting = true
		elif (body.name == "Player2"):
			var particle = $Player2.find_child("CPUParticles2D")
			particle.global_position.y = $Ball.global_position.y
			particle.emitting = true
	if body.is_in_group("muro"):
		$WhooshAudio.play()


func _on_goal_p_2_body_entered(_body):
	if(Global.Cooperative):
		Global.ScoreCop = 0
		$ScoreCop.text = str(Global.ScoreCop)
	else:
		Global.ScoreP2 += 1
		$ScoreP2.text = str(Global.ScoreP2)

	$GOAL.visible = true
	await get_tree().create_timer(2.0).timeout

	if(Global.ScoreP2 < Global.max_goals):
		$Ball.reset = true
		Global.velocity = Global.VELOCITY_BASE
		$GOAL.visible = false
		$TimerSpeedBall.set_wait_time($TimerSpeedBall.get_wait_time())
		$TimerSpeedBall.start()
	else:
		$GOAL.text = "PLAYER 2 WIN"
		$NewGameButton.visible = true
		pause = true
		$TimerSpeedBall.stop()


func _on_goal_p_1_body_entered(_body):
	if(Global.Cooperative):
		Global.ScoreCop = 0
		$ScoreCop.text = str(Global.ScoreCop)
	else:
		Global.ScoreP1 += 1
		$ScoreP1.text = str(Global.ScoreP1)

	$GOAL.visible = true
	await get_tree().create_timer(2.0).timeout

	if(Global.ScoreP1 < Global.max_goals):
		$Ball.reset = true
		Global.velocity = Global.VELOCITY_BASE
		$GOAL.visible = false
		$TimerSpeedBall.set_wait_time($TimerSpeedBall.get_wait_time())
		$TimerSpeedBall.start()
	else:
		$GOAL.text = "PLAYER 1 WIN"
		$NewGameButton.visible = true
		pause = true
		$TimerSpeedBall.stop()


func _on_timer_speed_ball_timeout():
	$Ball._speed += $Ball.speedBallIncrease
	Global.velocity += 1


func _on_new_game_button_pressed():
	MusicController.clicksound.play()
	get_tree().reload_current_scene()


func _on_pause_button_pressed():
	MusicController.clicksound.play()
	pause = true
	$TimerSpeedBall.stop()
	$PauseButton.visible = false
	$Ball.pause = true
	$Pause.visible = true


func _on_pause_on_play():
	MusicController.clicksound.play()
	$PunchAudio.volume_db = linear_to_db(MusicController.volume)
	$WhooshAudio.volume_db = linear_to_db(MusicController.volume)
	$PauseButton.visible = true
	$TimerSpeedBall.start()
	pause = false
	$Ball.pause = false
	$Pause.visible = false


func on_hover_button():
	MusicController.hoversound.play()
