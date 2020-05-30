extends KinematicBody2D

var speed = 100
var jumpTime = 0.2

var velocity = Vector2()
var isJumping = false
var jumpCounter = jumpTime

func _physics_process(delta):
	velocity = Vector2()

	if Input.is_action_pressed('ui_up') and is_on_floor():
		isJumping = true
	
	if isJumping:
		velocity.y -= speed
		jumpCounter -= delta
	else:
		velocity.y += speed

	if jumpCounter < 0:
		isJumping = false
		jumpCounter = jumpTime
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += speed
		$sprite.play("run")
		$sprite.set_flip_h(false)
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= speed
		$sprite.play("run")
		$sprite.set_flip_h(true)
	else:
		$sprite.stop()

	velocity = move_and_slide(velocity, Vector2(0, -1))