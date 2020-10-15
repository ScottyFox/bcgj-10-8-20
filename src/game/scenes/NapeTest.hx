package game.scenes;

import game.debug.MapPhysicsData;
import game.debug.NapeBall;
import game.objects.EnemyTest;
import core.input.keyboard.Key;
import core.input.Pointer;
import kha.math.Random;
import core.gameobjects.Image;
import core.gameobjects.Sprite;

import nape.space.Space;
import nape.space.Broadphase;
import nape.phys.Body;
import nape.phys.BodyList;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.geom.Vec2;
import nape.util.Debug;
import nape.util.BitmapDebug;
import nape.util.ShapeDebug;
import nape.constraint.PivotJoint;

import core.scene.Scene;

class NapeTest extends Scene {
  private var space:Space;
  
  private var _enemytest:EnemyTest;
  private var _player:Sprite;
  private var _star:Image;
  private var _ball1:NapeBall;
  private var _ball2:NapeBall;
  
  private var _keys:{
    w:Key,
    a:Key,
    s:Key,
    d:Key
  };

  public function new() {
    super({
      key: 'Play',
      active: false,
      visible: true
    });
  }

  override function preload() {
    load.image('test_groundmap', 'test_groundmap');
    load.image('star', 'star');
    load.image('phys_circle','phys_circle');
    load.image('turret_bottom', 'turret_bottom');
    load.image('turret_top', 'turret_top');
    load.image('turret_bullet', 'turret_bullet');
    load.image('item_pizza', 'item_pizza');
    load.image('astro', 'astro');
    load.spritesheet('dude', 'dude', { frameWidth: 32, frameHeight: 48 });
  }

	override function create() {
    var sky:Image = new Image(this, 400, 300, 'test_groundmap');
    sky.x = sky.width/2;
    sky.y = sky.height/2;
    sys.displayList.add([sky]);
    



    _star = new Image(this, 450, 300, 'star');
    _star.setScale(2);
    _star.setAlpha(0.5);

    sys.displayList.add([_star]);



    _player = new Sprite(this, 600, 400, 'dude');
    
    sys.displayList.add([_player]);
    sys.updateList.add(_player);

    setUp_Space();

		// Our player animations, turning, walking left and walking right.
		anims.create({
			key: 'left',
      frames: anims.generateFrameNumbers('dude', { start: 0, end: 3 }),
			skipMissedFrames: false,
			frameRate: 10,
			repeat: -1
		});

		anims.create({
			key: 'turn',
      frames: anims.generateFrameNumbers('dude', { start: 4, end: 5 }),
			skipMissedFrames: false,
			frameRate: 20
		});

		anims.create({
			key: 'right',
      frames: anims.generateFrameNumbers('dude', { start: 5, end: 8 }),
			skipMissedFrames: false,
			frameRate: 10,
			repeat: -1
		});

    _keys = {
      w: input.keyboard.addKey('W'),
      a: input.keyboard.addKey('A'),
      s: input.keyboard.addKey('S'),
			d: input.keyboard.addKey('D')
    };

    cameras.main.startFollow(_player);
  }

  function setUp_Space() {
    
    

    _ball1 = new NapeBall(this, 200, 200, 20, 'phys_circle');
    _ball2 = new NapeBall(this, 215, 100, 40, 'phys_circle');
    
    sys.displayList.add([_ball1]);
    sys.displayList.add([_ball2]);
    sys.updateList.add(_ball1);
    sys.updateList.add(_ball2);

    var w = sys.scale.gameSize.width;
    var h = sys.scale.gameSize.height;

    var gravity = Vec2.weak(0, 0);
    space = new Space(gravity);
    space.worldLinearDrag = 10;

    _enemytest = new EnemyTest(this,400, 300);
    _enemytest.target = _player;
    sys.displayList.add(_enemytest.getChildren());
    sys.updateList.add(_enemytest);

    //debug = new KhaDebug(sys.renderer.graphics,w, h,0xffffff,true);

    var floor = new Body(BodyType.STATIC);
    floor.shapes.add(new Polygon(Polygon.rect(50, (h - 50), (w - 100), 1)));
    
    floor.space = space;
    

    var map = MapPhysicsData.create_testmap(BodyType.STATIC);
    map.position.setxy(0, 0);
    map.space = space;
    for(shape in map.shapes){
      var shapeCom:Vec2 = shape.worldCOM;
      var dip:Image = new Image(this, shapeCom.x, shapeCom.y, 'phys_circle');
      dip.setScale(0.1);
      sys.displayList.add([_ball1]);
      sys.displayList.add([dip]);
    }

    _ball1.setSpace(space);
    _ball2.setSpace(space);
    _enemytest.setSpace(space);
  }

  override function update(time:Float, delta:Float) {
    space.step(1/60);
    //_star.x = ball.position.x;
    //_star.y = ball.position.y;
    _star.rotation += 0.1;

    if (_keys.w.isDown) {
      _player.y -= 100 * delta;
      _ball1.force.y = -1000;
		} else if (_keys.s.isDown) {
      _player.y += 100 * delta;
      _ball1.force.y = 1000;
    }else{
      _ball1.force.y = 0;
    }

		if (_keys.a.isDown) {
      _player.x -= 100 * delta;
      _ball1.force.x = -1000;
			_player.anims.play('left', true);
		} else if (_keys.d.isDown) {
      _player.x += 100 * delta;
      _ball1.force.x = 1000;
			_player.anims.play('right', true);
    } else {
      _ball1.force.x = 0;
			_player.anims.play('turn');
    }
  }
}