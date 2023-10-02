extends Node

var purpleKey = false
var blueKey = false

#Abilities

var moveInWater = false
var rotateLevel = false
var canJump = false
var gravityChanged = false
var radioactiveJumpPad = false
var mirrorLevel = false

var p1 = false
var p2 = false
var p3 = false
var p4 = false
var p5 = false
var p6 = false

var rotateKey = false
var bKey = false
var pKey = false
var uKey = false
var jumpPadKey = false

var shipGone = false

func everythingCollected():
	return (p1 and p2 and p3 and p4 and p5 and p6)

func restartLevel():
	moveInWater = false
	rotateLevel = false
	canJump = false
	gravityChanged = false
	radioactiveJumpPad = false
	mirrorLevel = false
	p1 = false
	p2 = false
	p3 = false
	p4 = false
	p5 = false
	p6 = false
	purpleKey = false
	blueKey = false
