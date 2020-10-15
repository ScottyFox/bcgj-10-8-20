package game.objects;

import nape.space.Space;
import core.scene.Scene;
import core.gameobjects.RenderableGameObject;
import core.gameobjects.Image;
import core.gameobjects.GameObject;
import nape.geom.Vec2;

class EnemyTest extends GameObject{
  public var childs:List<GameObject>;
  public var base:Image;
  public var top:Image;
  public var target:RenderableGameObject;
  private var _space:Space;
  private var shoot_time:Float = 3;
  private var shoot_delta:Float = 0;
  private var bullet_speed:Float = 80;

  public function new(scene:Scene, x:Float, y:Float) {
    super(scene,'enemy');
    base = new Image(scene, x, y, 'turret_bottom');
    base.setOrigin(8.5/17,13/17);
    top = new Image(scene, x, y-11, 'turret_top');
    top.setOrigin(.5,.5);
  }
  public function setSpace(space:Space){
    this._space = space;
  }

  override public function preUpdate(time:Float, delta:Float) {
    if(target!=null)
      {
        top.rotation = Math.atan2(target.y-top.y,target.x-top.x);
        shoot_delta+=delta;
        if(shoot_delta>=shoot_time)
          {
            shoot_delta -= shoot_time;
            var bullet_dir = Vec2.weak(Math.cos(top.rotation),Math.sin(top.rotation));
            var bullet_vel = bullet_dir.mul(bullet_speed);
            var dir_test = bullet_dir.mul(12, true).add(Vec2.weak(base.x,base.y-11));
            var bullet:EnemyBullet = new EnemyBullet(scene,dir_test.x,dir_test.y,bullet_vel);
            bullet.setSpace(_space);
            scene.sys.displayList.add([bullet]);
            scene.sys.updateList.add(bullet);
          }
      }
  }

  public function getChildren():Array<GameObject>{
    return [base,top];
  }
}