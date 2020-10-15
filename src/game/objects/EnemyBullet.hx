package game.objects;

import core.gameobjects.RenderableGameObject;
import core.Renderer;
import core.cameras.Camera;
import core.scene.Scene;
import core.gameobjects.Image;

import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.space.Space;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.geom.Vec2;

import game.physics.CustomCbTypes;

class EnemyBullet extends Image{
  private var interactionListener:InteractionListener;
  private var colType:CbType;
  public var napeBody:Body;
  public var force:Vec2;

	public function new(scene:Scene, x:Float, y:Float, vel:Vec2) {
    super(scene, x, y, 'turret_bullet', '');
    this.force = vel;
    setUp(x,y);
  }
  
  //Init of Nape Body
  public function setUp(x:Float, y:Float)
    {
      var r = 4;
      napeBody = new Body(BodyType.DYNAMIC);
      napeBody.allowRotation = false;
      napeBody.isBullet = true;
      napeBody.position.setxy(x, y);

      var s = new Circle(r);
      s.sensorEnabled = true;
      s.cbTypes.add(CustomCbTypes.HITBOX);
      napeBody.shapes.add(s);

      napeBody.userData.data = {type:"enemy_bullet" , gameobject:this};
    }
  
  //Syncs up Position and Rotation with Nape Body
  public function syncDisplay()
    {
      this.x = napeBody.position.x;
      this.y = napeBody.position.y;
    }

  //Sets Current Space
  public function setSpace(space:Space)
    {
      napeBody.space = space;
      //interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.ANY, colType, ColTypesTest.WALL, colliding);
		  //space.listeners.add(interactionListener);
    }

    @:keep public function hitboxEvent(colliderData:Dynamic) {
    if(colliderData.type == "friendly")
      {
        trace("Hit Player!");
        destroy(true);
      }
    }

    @:keep public function wallEvent() {
          trace("Hit wall!");
          destroy(true);
    }

    override public function preUpdate(time:Float, delta:Float) {
      napeBody.velocity.set(force);//.force = cast force;
    }

    override public function preDestroy() {
    scene.sys.displayList.remove([this]);
    scene.sys.updateList.remove(this);
    napeBody.space = null;
    };

	/**
	 * Renders this Game Object with the Canvas Renderer to the given Camera.
	 * The object will not render if any of its renderFlags are set or it is being actively filtered out by the Camera.
	 * This method should not be called directly. It is a utility function of the Render module.
	 */
	override public function render(renderer:Renderer, camera:Camera) {
    syncDisplay();
    renderer.batchImage(this, frame, camera);
	}
}