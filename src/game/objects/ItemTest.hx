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
import nape.shape.Circle;
import nape.geom.Vec2;

class ItemTest extends Sprite{

  public var colType:CbType;
  public var napeBody:Body;
  private var _pickedup:Bool = false;
  private var _debug = true;//debugging
  private var _shape:Circle;//debugging
  private var _target:{x:Float,y:Float};
  private var _floatspeed = 5;
  private var _destroyrange = 5;

  public function new(scene:Scene,space:Space ,x:Float, y:Float) {
    super(scene,x,y,'item_pizza');
    setUp(x,y,space);
  }

  //Init of Nape Body
  private function setUp(x:Float, y:Float, space:Space)
    {
      napeBody = new Body(BodyType.DYNAMIC);
      napeBody.allowRotation = false;
      napeBody.isBullet = false;
      napeBody.position.setxy(x, y);

      _shape = new Circle(15);
      _shape.sensorEnabled = true;
      _shape.cbTypes.add(CustomCbTypes.HITBOX);
      napeBody.shapes.add(_shape);

      var _col = new Circle(7);
      napeBody.shapes.add(_col);

      napeBody.userData.data = {type:"item" ,item:"pizza" , gameobject:this};

      napeBody.space = space;
    }

    @:keep public function hitboxEvent(colliderData:Dynamic) {
      if(colliderData.type=="friendly"){
      napeBody.space = null;
      _target = cast colliderData.gameobject;
      _pickedup = true;
      }
    }

    private function distance(x1:Float,y1:Float,x2:Float,y2:Float):Float
      {
        return Math.sqrt(Math.pow(x2-x1,2)+Math.pow(y2-y1,2));
      }

    override public function preUpdate(time:Float, delta:Float) {
    if(_pickedup){
      if(_target!=null)
        {
          x += (_target.x-x)*(_floatspeed/100);
          y += (_target.y-y)*(_floatspeed/100);
          if(distance(x,y,_target.x,_target.y)<=_destroyrange)
            {
            destroy(true);
            }
        }else{
          destroy(true);
        }
    }
    }

    override public function preDestroy() {
      scene.sys.displayList.remove([this]);
      scene.sys.updateList.remove(this);
    };

    //Syncs up Position and Rotation with Nape Body
    public function syncDisplay()
      {
        if(napeBody.space!=null)
          {
            this.x = napeBody.position.x;
            this.y = napeBody.position.y;
          }
      }

    override public function render(renderer:Renderer, camera:Camera) {
      syncDisplay();
      renderer.batchImage(this, frame, camera);
      if(_debug&&napeBody.space!=null)
        {
        var pos:Vec2;
		    pos = napeBody.position;
        renderer.graphics.pushRotation(napeBody.rotation, pos.x, pos.y);
        kha.graphics2.GraphicsExtension.drawCircle(renderer.graphics,_shape.body.position.x - camera.scrollX, _shape.body.position.y - camera.scrollY, 15);
        renderer.graphics.popTransformation();
        }
    }
}
