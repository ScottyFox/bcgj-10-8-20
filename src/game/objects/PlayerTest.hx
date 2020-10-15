package game.objects;

import game.physics.CustomCbTypes;

import core.Renderer;
import core.animations.AnimationManager;
import core.cameras.Camera;
import core.gameobjects.Sprite;
import core.scene.Scene;
import core.input.keyboard.Key;

import nape.space.Space;
import nape.callbacks.CbType;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.geom.Vec2;

class PlayerTest extends Sprite{

  public var colType:CbType;
  public var napeBody:Body;

  private var _keys:{up:Key,down:Key,left:Key,right:Key};
  private var _speed:Float = 60;
  private var _velocity:Vec2 = new Vec2(0,0);
  private var _inputDirection:Vec2 = new Vec2(0,0);
  private var _inputAngle:Float = 0;//In Radians
  private var _isMoving:Bool = false;
  private var _currentHoriModifier = "right";
  private var _currentVertModifier = "down";
  private var _currentStateModifier = "idle";
  private var _debug = true;//debugging
  private var _shape:Polygon;//debugging

  public function new(scene:Scene,space:Space ,x:Float, y:Float) {
    super(scene,x,y,'astro');
    setUp(x,y,space);
  }

  public static function init_astroAnimations(anims:AnimationManager){
    anims.create({
			key: 'left_down_walk',
      frames: anims.generateFrameNumbers('astro', { start: 0, end: 1 }),
			skipMissedFrames: false,
			frameRate: 10,
			repeat: -1
    });
    anims.create({
			key: 'left_up_walk',
      frames: anims.generateFrameNumbers('astro', { start: 2, end: 3 }),
			skipMissedFrames: false,
			frameRate: 10,
			repeat: -1
    });
    anims.create({
			key: 'left_down_idle',
      frames: anims.generateFrameNumbers('astro', { start: 0, end: 1 }),
			skipMissedFrames: false,
			frameRate: 10
    });
    anims.create({
			key: 'left_up_idle',
      frames: anims.generateFrameNumbers('astro', { start: 1, end: 2 }),
			skipMissedFrames: false,
			frameRate: 10
    });

    anims.create({
			key: 'right_down_walk',
      frames: anims.generateFrameNumbers('astro', { start: 4, end: 5 }),
			skipMissedFrames: false,
			frameRate: 10,
			repeat: -1
    });
    anims.create({
			key: 'right_up_walk',
      frames: anims.generateFrameNumbers('astro', { start: 6, end: 7 }),
			skipMissedFrames: false,
			frameRate: 10,
			repeat: -1
    });
    anims.create({
			key: 'right_down_idle',
      frames: anims.generateFrameNumbers('astro', { start: 3, end: 4 }),
			skipMissedFrames: false,
			frameRate: 10
    });
    anims.create({
			key: 'right_up_idle',
      frames: anims.generateFrameNumbers('astro', { start: 5, end: 6 }),
			skipMissedFrames: false,
			frameRate: 10
    });
  }

  //Init of Nape Body
  private function setUp(x:Float, y:Float, space:Space)
    {
      napeBody = new Body(BodyType.DYNAMIC);
      napeBody.allowRotation = false;
      napeBody.isBullet = true;
      napeBody.position.setxy(x, y);

      _shape = new Polygon(Polygon.box(10, 20));
      _shape.cbTypes.add(CustomCbTypes.HITBOX);
      napeBody.shapes.add(_shape);

      napeBody.userData.data = {type:"friendly" , gameobject:this};

      napeBody.space = space;
    }

  //On Update Frames, Check Inputs.
  private function checkInput()
    {
      _isMoving = false;
      if(_keys!=null){
        _inputDirection.setxy(0, 0);
        var n = false;
        var b = false;
        if(_keys.up!=null&&_keys.up.isDown){
          _currentVertModifier = "up";
          _inputDirection.y = -1;
          _isMoving = true;
          n = true;
          }
        else if(_keys.down!=null&&_keys.down.isDown){
          _currentVertModifier = "down";
          _inputDirection.y = 1;
          _isMoving = true;
          n = true;
          }
        if(_keys.left!=null&&_keys.left.isDown){
          _currentHoriModifier = "left";
          _inputDirection.x = -1;
          _isMoving = true;
          b = true;
          }
        else if(_keys.right!=null&&_keys.right.isDown){
          _currentHoriModifier = "right";
          _inputDirection.x = 1;
          _isMoving = true;
          b = true;
          }
          if(n&&b)
            {
              //_inputDirection.x /= 2;
              //_inputDirection.y /= 2;
            }
      }
      if(_isMoving){
        //_inputAngle = Math.atan2(_inputDirection.y,_inputDirection.x);
        //_velocity = Vec2.weak(Math.cos(_inputAngle),Math.sin(_inputAngle)).mul(_speed);
        _inputDirection.normalise();
        _inputAngle = _inputDirection.angle;
        _velocity = _inputDirection.mul(_speed);
        _currentStateModifier = "walk";
        }
      else{
        _velocity.setxy(0, 0);
        _currentStateModifier = "idle";
        }
    }
  //Set Basic Controls
  public function setControls(?up:Key=null,?down:Key=null,?left:Key=null,?right:Key=null){
      _keys = {
      up:up,
      down:down,
      left:left,
      right:right
      }
    }

    @:keep public function hitboxEvent(colliderData:Dynamic) {
      trace("Player : Hitbox");
      }
  
    @:keep public function wallEvent() {
      trace("Player : Wall");
    }

    override public function preUpdate(time:Float, delta:Float) {
    checkInput();
    anims.play(_currentHoriModifier+"_"+_currentVertModifier+"_"+_currentStateModifier, true);
    napeBody.velocity.set(_velocity);
    }

    //Syncs up Position and Rotation with Nape Body
    public function syncDisplay()
      {
        this.x = napeBody.position.x;
        this.y = napeBody.position.y;
      }

    override public function render(renderer:Renderer, camera:Camera) {
      syncDisplay();
      renderer.batchImage(this, frame, camera);
      if(_debug)
        {
        var pos:Vec2;
		    pos = napeBody.position;
        renderer.graphics.pushRotation(napeBody.rotation, pos.x, pos.y);
        renderer.graphics.drawRect(_shape.body.position.x - 10 / 2 - camera.scrollX, _shape.body.position.y - 20 / 2 - camera.scrollY, 10, 20);
        renderer.graphics.popTransformation();
        }
    }
}
