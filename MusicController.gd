extends Node

# Music
var DNA8b = load("res://assets/audio/8Bit DNA Loop.ogg")
var MiniGamer8b = load("res://assets/audio/8Bit Mini Gamer Loop.ogg")
var AnimeBeat = load("res://assets/audio/Anime Beat Loop.ogg")

var counter = 0
var musics = [
	{"name":"Anime Beat", "audio": AnimeBeat}, 
	{"name":"8Bit DNA ", "audio": DNA8b},
	{"name":"8Bit Mini Gamer", "audio": MiniGamer8b}]

var volume = 0


func _ready():
	$Music.volume_db = volume
	play_AnimeBeat()

func play_music():
	counter = fmod(counter + 1, 3)
	$Music.stream = musics[counter].audio
	$Music.play()

func play_DNA8b():
	$Music.stream = DNA8b
	$Music.play()

func play_MiniGamer8b():
	$Music.stream = MiniGamer8b
	$Music.play()

func play_AnimeBeat():
	$Music.stream = AnimeBeat
	$Music.play()

func turn_up_volume():
	if(volume < 20):
		volume +=1
	$Music.volume_db = volume

func turn_down_volume():
	if(volume > -20):
		volume -=1
	$Music.volume_db = volume
