extends Node

const GRAV = 500

var levels = {
	0: {"scene": "res://Scenes/Levels/Level1.tscn", "locked": false},
	1: {"scene": "res://Scenes/Levels/Level2.tscn", "locked": true},
	2: {"scene": "res://Scenes/Levels/Test.tscn", "locked": true},
	3: {"scene": "res://Scenes/Levels/LevelSelect.tscn", "locked": true}
}

var currentLevelNum = null

var hasGun = false

var lightsOut = false

var spacemenSaved = 0
