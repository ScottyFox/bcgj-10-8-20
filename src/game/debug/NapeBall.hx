package game.debug;

import core.gameobjects.RenderableGameObject;
import core.Renderer;
import core.cameras.Camera;
import core.scene.Scene;
import core.gameobjects.Image;

import nape.space.Space;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.geom.Vec2;

class NapeBall extends Image{
  public var napeBody:Body;
  public var force:Vec2;

	public function new(scene:Scene, x:Float, y:Float,r:Float, texture:String, ?frame:String = '') {
    super(scene, x, y, texture, frame);
    setUp(x,y,r);
  }
  
  //Init of Nape Body
  public function setUp(x:Float, y:Float ,r:Float)
    {
      napeBody = new Body(BodyType.DYNAMIC);
      napeBody.shapes.add(new Circle(r));
      napeBody.position.setxy(x, y);

      //To-Do: Move this to the update function
      var size_dif:Float = r*2;
      if(width>=height)
        {
          size_dif /= height;
        }
      else{
          size_dif /= width;
        }
      setScale(size_dif);
      force = new Vec2(0,0);
    }
  
  //Syncs up Position and Rotation with Nape Body
  public function syncDisplay()
    {
      this.x = napeBody.position.x;
      this.y = napeBody.position.y;
      this.rotation = napeBody.rotation;
    }

  //Sets Current Space
  public function setSpace(space:Space)
    {
      napeBody.space = space;
    }

    override public function preUpdate(time:Float, delta:Float) {
      napeBody.force = cast force;
    }

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