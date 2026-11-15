extends CharacterBody2D
var playerHealth = 100
var growthRate = 0.1

# Platformer Movement

func _physics_process(delta: float) -> void:
	const SPEED = 300.0
	const JUMP_VELOCITY = -400.0
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	

func _on_pickup_area_area_entered(area: Area2D) -> void:
	# Need to make player bigger
	if area.is_in_group("Blue Blob"):
		scale += Vector2(growthRate, growthRate)
		area.queue_free()
		playerHealth += 10
		$CanvasLayer/playerHealth.text = "Health: " + str(playerHealth)
		
	# This is for hand enemy, we need to make it lower health	
	if area.is_in_group("Hand Enemy"):
		scale -= Vector2()
		playerHealth -= 10
		$CanvasLayer/playerHealth.text = "Health: " + str(playerHealth)
		
		
