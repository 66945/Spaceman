extends Control

const keyMap = {
	KEY_A: "a",KEY_B: "b",KEY_C: "c",KEY_D: "d",KEY_E: "e",KEY_F: "f",
	KEY_G: "g",KEY_H: "h",KEY_I: "i",KEY_J: "j",KEY_K: "k",KEY_L: "l",
	KEY_M: "m",KEY_N: "n",KEY_O: "o",KEY_P: "p",KEY_Q: "q",KEY_R: "r",
	KEY_S: "s",KEY_T: "t",KEY_U: "u",KEY_V: "v",KEY_W: "w",KEY_X: "x",
	KEY_Y: "y",KEY_Z: "z"
}
const maxWrong = 5

var codeWord = "mississippi"

var keysLeft = "abcdefghijklm\nnopqrstuvwxyz"
var keysUsed = ""

var startKey = null

var correct = false
var wrongs = 0

func _ready():
	$KeysLabel.text = keysLeft
	updateCode()
	
	for key in keyMap.keys():
		if Input.is_key_pressed(key):
			startKey = key

func _process(_delta):
	if startKey != null:
		if Input.is_key_pressed(startKey):
			return
		else:
			startKey = null
	elif not correct and visible:
		for key in keyMap.keys():
			if Input.is_key_pressed(key) and not keyMap[key] in keysUsed:
				keysLeft = keysLeft.replace(keyMap[key], "")
				keysUsed += keyMap[key]
				
				$KeysLabel.text = keysLeft
				
				if keyMap[key] in codeWord:
					updateCode()
				else:
					print("wrong")
					updateWrongs()

func updateCode():
	var result = ""
	var cNum = 0
	
	for c in codeWord:
		if c in keysUsed:
			result += c
			cNum += 1
		else:
			result += "_"
	
	$CodeLabel.text = result
	if cNum == len(result):
		print("correct")
		correct = true

func updateWrongs():
	wrongs += 1
	
	$Lives.get_node("Life" + str(wrongs)).visible = false
	
	if wrongs >= maxWrong:
		reset()

func reset():
	keysLeft = "abcdefghijklm\nnopqrstuvwxyz"
	keysUsed = ""
	
	wrongs = 0
	for child in $Lives.get_children():
		child.visible = true
	
	$KeysLabel.text = keysLeft
	updateCode()
	
	for key in keyMap.keys():
		if Input.is_key_pressed(key):
			startKey = key
