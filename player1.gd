extends CharacterBody2D

const WALK_SPEED := 40.0

var player_num := 1
var action_move_right := "player1_right"
var action_move_left := "player1_left"
var action_move_down := "player1_down"
var action_move_up := "player1_up"
var action_zap  := "player1_zap"
var input_direction := Vector2(0,0)      #Last direction of movement detected.

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	var prefix = "player" + str(self.player_num)
	self.action_move_right = prefix + "_right"
	self.action_move_left = prefix + "_left"
	self.action_move_up = prefix + "_up"
	self.action_move_down = prefix + "_down"
	print("Settings set to " + self.action_move_right + " " + self.action_move_left)	

func get_input():
	self.input_direction = Input.get_vector(action_move_left, 
											action_move_right, 
											action_move_up,
											action_move_down)
	velocity = self.input_direction * WALK_SPEED
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()

func _process(_delta):
	if Input.is_action_pressed(action_move_right):
		_animated_sprite.play("drgn-right")
#		'advance' is in the tutorial but 
#		"Invalid call. Nonexistent function 'advance' in base 'AnimatedSprite2D'."
#		Need to switch to 'animation_player' from 'animated_sprite'
#		_animated_sprite.advance(0)
	elif Input.is_action_pressed(action_move_left):
		_animated_sprite.play("drgn-left")
	elif Input.is_action_pressed(action_move_up):
		_animated_sprite.play("drgn-up")
	elif Input.is_action_pressed(action_move_down):
		_animated_sprite.play("drgn-down")
	else:
#		This is supposed to stop the animation, but it seems to end it permanently.		
#		_animated_sprite.stop()
		_animated_sprite.play("drgn-parade")
