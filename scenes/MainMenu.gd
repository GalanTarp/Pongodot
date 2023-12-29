extends Control


func _process(delta):
	Global.move_background(delta, $TextureRect)



func _on_start_button_pressed():
	Global.ScoreP1 = 0
	Global.ScoreP2 = 0
	MusicController.clicksound.play()
	get_tree().change_scene_to_file("res://scenes/mode_game.tscn")


func _on_exit_button_pressed():
	MusicController.clicksound.play()
	get_tree().quit()


func _on_options_button_pressed():
	MusicController.clicksound.play()
	get_tree().change_scene_to_file("res://scenes/options.tscn")


func _on_start_button_mouse_entered():
	MusicController.hoversound.play()


func _on_options_button_mouse_entered():
	MusicController.hoversound.play()


func _on_exit_button_mouse_entered():
	MusicController.hoversound.play()
