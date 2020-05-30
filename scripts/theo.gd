extends KinematicBody2D

export (int) var speed = 100

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	
	velocity.y += 0.01
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		$sprite.play("run")
		$sprite.set_flip_h(false)
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		$sprite.play("run")
		$sprite.set_flip_h(true)
	else:
		$sprite.stop()

	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
