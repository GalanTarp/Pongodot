extends Control

func _ready():
	$Song.text = MusicController.musics[MusicController.counter].name
	$ProgressBar.value = MusicController.volume
	$VSlider.value = MusicController.volume

func _process(delta):
	Global.move_background(delta, $TextureRect)
	print($VolumeDownButton.is_pressed)


func _on_volume_up_button_pressed():
	MusicController.clicksound.play()
	MusicController.turn_up_volume()
	$ProgressBar.value = MusicController.volume
	$VSlider.value = MusicController.volume


func _on_volume_down_button_pressed():
	MusicController.clicksound.play()
	MusicController.turn_down_volume()
	$ProgressBar.value = MusicController.volume
	$VSlider.value = MusicController.volume


func _on_next_button_pressed():
	MusicController.clicksound.play()
	MusicController.play_music()
	$Song.text = MusicController.musics[MusicController.counter].name


func _on_back_button_pressed():
	MusicController.clicksound.play()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_v_slider_value_changed(value):
	$ProgressBar.value = value
	MusicController.change_volume(value)


func _on_volume_up_button_mouse_entered():
	MusicController.hoversound.play()


func _on_volume_down_button_mouse_entered():
	MusicController.hoversound.play()


func _on_next_button_mouse_entered():
	MusicController.hoversound.play()


func _on_back_button_mouse_entered():
	MusicController.hoversound.play()
