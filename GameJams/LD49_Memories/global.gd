extends Node

var CAMERA_ZOOM_EM = Vector2(3,3)
var CAMERA_ZOOM_DEF = Vector2(1.2,1.2)

var music = true

var timeMusic = 0

func zoomInCamera(def:bool, value):
	if (def):
		if (CAMERA_ZOOM_DEF.x > 0.6):
			CAMERA_ZOOM_DEF.x = CAMERA_ZOOM_DEF.x + value
			CAMERA_ZOOM_DEF.y = CAMERA_ZOOM_DEF.y + value
	else:
		if (CAMERA_ZOOM_EM.x > 1):
			CAMERA_ZOOM_EM.x = CAMERA_ZOOM_EM.x + value
			CAMERA_ZOOM_EM.y = CAMERA_ZOOM_EM.y + value

func zoomOutCamera(def:bool, value):
	if (def):
		if (CAMERA_ZOOM_DEF.x < 5):
			CAMERA_ZOOM_DEF.x = CAMERA_ZOOM_DEF.x + value
			CAMERA_ZOOM_DEF.y = CAMERA_ZOOM_DEF.y + value
	else:
		if (CAMERA_ZOOM_EM.x < 6):
			CAMERA_ZOOM_EM.x = CAMERA_ZOOM_EM.x + value
			CAMERA_ZOOM_EM.y = CAMERA_ZOOM_EM.y + value
