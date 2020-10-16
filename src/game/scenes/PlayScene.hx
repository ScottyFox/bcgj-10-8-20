package game.scenes;

import game.objects.ItemTest;
import game.debug.MapPhysicsData;
import game.objects.EnemyTest;
import game.objects.PlayerTest;
import nape.phys.BodyType;
import nape.geom.Vec2;

import game.physics.NapeScene;
import core.input.keyboard.Key;
import core.input.Pointer;
import kha.math.Random;
import core.gameobjects.Image;
import core.gameobjects.Sprite;
import game.scripts.RailsObject;

import game.scripts.TilemapModule;
import game.scripts.TilemapLoader;

import core.scene.Scene;

class PlayScene extends NapeScene {
  private var _enemytest:EnemyTest;
  private var _player:PlayerTest;
  private var _star:Image;
  private var _starRail:RailsObject;
  private var _itemTest:ItemTest;
  private var _tilemapM:TilemapModule;

  private var _keys:{
    w:Key,
    a:Key,
    s:Key,
    d:Key
  };


  public function new() {
    super('Play',false,true);
  }

  override function preload() {
    load.image('test_groundmap', 'test_groundmap');
    load.image('star', 'star');
    load.image('phys_circle','phys_circle');
    load.image('turret_bottom', 'turret_bottom');
    load.image('turret_top', 'turret_top');
    load.image('turret_bullet', 'turret_bullet');
    load.image('item_pizza', 'item_pizza');
    load.spritesheet('test_tiles', 'test_tiles', { frameWidth: 24, frameHeight: 24 });
    load.spritesheet('astro', 'astro', { frameWidth: 24, frameHeight: 24 });
    load.spritesheet('dude', 'dude', { frameWidth: 32, frameHeight: 48 });
  }

	override function create() {
    
    initspace({x:0,y:0},20,20);

    //var sky:Image = new Image(this, 400, 300, 'test_groundmap');
    //sky.x = sky.width/2;
    //sky.y = sky.height/2;
    //sys.displayList.add([sky]);

    //_tilemap = new LargeScaleTileMap(this,0,0,'test_tiles',{width:5,height:5},["0","0"]);
    //sys.displayList.add([_tilemap]);
    _tilemapM = new TilemapModule(this,0,0,'test_tiles',{width:5,height:5},["0","1"],0);
    sys.displayList.add([_tilemapM]);
    TilemapLoader.getMapData('dungeon_test',[0xFFFFFFFF,0xFF000000],_tilemapM.loadMapData);


    _star = new Image(this, 450, 300, 'star');
    _star.setScale(3);
    _star.setAlpha(0.5);
    trace(_star.originX,_star.originY);
    _star.originX = 1;
    _star.originY = 1;
    sys.displayList.add([_star]);

    _starRail = new RailsObject(this, 450, 300);
    _starRail.addPoints([{x:450,y:300,d:1},{x:550,y:300,d:1},{x:500,y:400,d:1},{x:450,y:300,d:1}]);
    _starRail.setLooping(true);
    _starRail.play();
    sys.updateList.add(_starRail);


    //var map = MapPhysicsData.create_testmap(BodyType.STATIC);
    //map.position.setxy(0, 0);
    //map.space = space;

    _keys = {
      w: input.keyboard.addKey('W'),
      a: input.keyboard.addKey('A'),
      s: input.keyboard.addKey('S'),
			d: input.keyboard.addKey('D')
    };

    PlayerTest.init_astroAnimations(anims);
    _player = new PlayerTest( this, space, 0, 0);
    _player.setControls(_keys.w,_keys.s,_keys.a,_keys.d);
    sys.displayList.add([_player]);
    sys.updateList.add(_player);

    //_enemytest = new EnemyTest(this,400, 300);
    //_enemytest.target = _player;
    //sys.displayList.add(_enemytest.getChildren());
    //sys.updateList.add(_enemytest);
    //_enemytest.setSpace(space);

    _itemTest = new ItemTest(this, space, 450 , 400);
    sys.displayList.add([_itemTest]);
    sys.updateList.add(_itemTest);

    cameras.main.startFollow(_player);
  }

  override function update(time:Float, delta:Float) {
    step(60);
    //_star.rotation += 0.1;
    _star.x += (_starRail.x - _star.x)*.02;
    _star.y += (_starRail.y - _star.y)*.02;
  }
}