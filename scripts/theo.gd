extends KinematicBody2D

var velocity
var speed = 100

var isJumping = false
var jumpTime = 0.2
var jumpCounter = jumpTime

var changeSceneTime = 1
var changeSceneCounter = changeSceneTime

var currentScene
var nextScene

func _physics_process(delta):
	if changeSceneCounter > 0:
		changeSceneCounter -= delta

	if Input.is_action_pressed('ui_accept') and changeSceneCounter < 0:
		currentScene = get_tree().current_scene.name
		nextScene = 'res://scenes/second.tscn' if currentScene != 'second' else 'res://scenes/first.tscn'
		get_tree().change_scene(nextScene)

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