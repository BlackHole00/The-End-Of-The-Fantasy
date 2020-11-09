extends KinematicBody2D


enum AnimationStateEnum {
	WALK_UP,
	WALK_DOWN,
	WALK_LEFT,
	WALK_RIGHT,
	STAND_UP,
	STAND_DOWN,
	STAND_LEFT,
	STAND_RIGHT
}

var animationState;
var speed = 100;
var movement = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	animationState = AnimationStateEnum.STAND_DOWN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement = Vector2()
	
	if   (Input.is_action_pressed("action_up")):
		movement.y -= 1.0
		animationState = AnimationStateEnum.WALK_UP
	elif (Input.is_action_pressed("action_down")):
		movement.y += 1.0
		animationState = AnimationStateEnum.WALK_DOWN
	elif   (Input.is_action_pressed("action_left")):
		movement.x -= 1.0
		animationState = AnimationStateEnum.WALK_LEFT
	elif (Input.is_action_pressed("action_right")):
		movement.x += 1.0
		animationState = AnimationStateEnum.WALK_RIGHT
	else:
		animationState = ToStandAnimation(animationState)
	
	print(animationState)
	
	self.move_and_collide(movement * delta * speed)
	UpdateAnimation(animationState)


func UpdateAnimation(inAnimationState):
	$AnimatedSprite.flip_h = false;
	match inAnimationState:
		AnimationStateEnum.STAND_UP:
			$AnimatedSprite.animation = "StandUp"
		AnimationStateEnum.STAND_DOWN:
			$AnimatedSprite.animation = "StandDown"
		AnimationStateEnum.STAND_LEFT:
			$AnimatedSprite.animation = "StandLeft"
		AnimationStateEnum.STAND_RIGHT:
			$AnimatedSprite.animation = "StandLeft"
			$AnimatedSprite.flip_h = true;

		AnimationStateEnum.WALK_UP:
			$AnimatedSprite.animation = "WalkUp"
		AnimationStateEnum.WALK_DOWN:
			$AnimatedSprite.animation = "WalkDown"
		AnimationStateEnum.WALK_LEFT:
			$AnimatedSprite.animation = "WalkLeft"
		AnimationStateEnum.WALK_RIGHT:
			$AnimatedSprite.animation = "WalkLeft"
			$AnimatedSprite.flip_h = true;

func ToStandAnimation(inAnimationState):
	match inAnimationState:
		AnimationStateEnum.WALK_UP:
			return AnimationStateEnum.STAND_UP
		AnimationStateEnum.WALK_DOWN:
			return AnimationStateEnum.STAND_DOWN
		AnimationStateEnum.WALK_LEFT:
			return AnimationStateEnum.STAND_LEFT
		AnimationStateEnum.WALK_RIGHT:
			return AnimationStateEnum.STAND_RIGHT
	return inAnimationState
