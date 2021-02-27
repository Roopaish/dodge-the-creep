extends Area2D

#export allows us to use this value in inspector
export var speed = 400 #playes speed (pixels/sec)
var screen_size #size of th game window


func _ready():#ready function is called when a node enters scene tree
	screen_size=get_viewport_rect().size
	hide() #At first the player is hidden
	
func _process(delta):#defines what player will do,input,move,play animatio
	var velocity =Vector2()#(x,y)
	if Input.is_action_pressed("ui_right"):
		velocity.x+=1
	if Input.is_action_pressed("ui_left"):
		velocity.x-=1
	if Input.is_action_pressed("ui_up"):
		velocity.y-=1
	if Input.is_action_pressed("ui_down"):
		velocity.y+=1
	if velocity.length()>0:#if two inputs are added, player will move faster diagonally so it is done to prevent that
		velocity=velocity.normalized()*speed# normalized sets velocity value to 1 and multiplied by desired speed, will orevent diagonal fast movement
		$AnimatedSprite.play() # shortcut of get_node("AnimatedSprite").play()
	else:
		$AnimatedSprite.stop()
	
	position+=velocity*delta #delta refers to frame length (time that previous frame take to complete) i.e the movement will remain contraint even if the frame rate changes
	position.x=clamp(position.x,0,screen_size.x) #clamp fix the player inside screen
	position.y=clamp(position.y,0,screen_size.y)

	if velocity.x!=0:
		$AnimatedSprite.animation="walk"
		$AnimatedSprite.flip_v=false #dont flip vertically
		$AnimatedSprite.flip_h=velocity.x<0
	elif velocity.y!=0:
		$AnimatedSprite.animation="up"
		$AnimatedSprite.flip_v=velocity.y>0

signal hit #emit send out when its collide with enemy


func _on_Player_body_entered(body):# from node 
	hide() # Players disappears after being hit
	emit_signal("hit") #signal is emitted each time eney hits the player
	$CollisionShape2D.set_deferred("disabled",true) #disabled so not to trigger hit signal more than once

func start(pos): #reset player when starting the game
	position=pos
	show()
	$CollisionShape2D.disabled=false
