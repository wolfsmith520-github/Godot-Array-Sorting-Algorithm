extends Control

@onready var numberlabel = $Label
@onready var progressbar = $ProgressBar

@export var labelValue:int
@export var progressbarValue:float

func _ready():
	numberlabel.text = str(labelValue)
	progressbar.value = progressbarValue * 100
