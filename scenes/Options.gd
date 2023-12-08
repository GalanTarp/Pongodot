extends Control

func _ready():
	$Song.text = MusicController.musics[MusicController.counter].name

func _process(delta):
	Global.move_background(delta, $TextureRect)


func _on_volume_up_button_pressed():
	MusicController.turn_up_volume()
	$ProgressBar.value = MusicController.volume


func _on_volume_down_button_pressed():
	MusicController.turn_down_volume()
	$ProgressBar.value = MusicController.volume


func _on_next_button_pressed():
	MusicController.play_music()
	$Song.text = MusicController.musics[MusicController.counter].name


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
