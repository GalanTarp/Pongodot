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


@export var clicksound:AudioStreamPlayer = null
@export var hoversound:AudioStreamPlayer = null

var volume = 0.2


func _ready():
	$Music.volume_db = linear_to_db(volume)
	$ClickSound.volume_db = linear_to_db(volume)
	$HoverSound.volume_db = linear_to_db(volume)
	play_AnimeBeat()
	clicksound = $ClickSound
	hoversound = $HoverSound

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
	if(volume < 1):
		volume +=0.01
	$Music.volume_db = linear_to_db(volume)
	$ClickSound.volume_db = linear_to_db(volume)
	$HoverSound.volume_db = linear_to_db(volume)

func turn_down_volume():
	if(volume > 0):
		volume -=0.01
	$Music.volume_db = linear_to_db(volume)
	$ClickSound.volume_db = linear_to_db(volume)
	$HoverSound.volume_db = linear_to_db(volume)

func change_volume(volumeAux):
	volume = volumeAux
	$Music.volume_db = linear_to_db(volume)
	$ClickSound.volume_db = linear_to_db(volume)
	$HoverSound.volume_db = linear_to_db(volume)
