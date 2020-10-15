package game.physics;

import haxe.ds.StringMap;
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
import nape.constraint.PivotJoint;

import nape.shape.Shape;
import nape.geom.Vec3;
import nape.dynamics.InteractionFilter;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.InteractionCallback;
import nape.phys.Material;
import nape.phys.FluidProperties;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.CbTypeList;
import nape.geom.AABB;

import core.scene.Scene;

class NapeScene extends Scene {
  public var space:Space;
  //To-Do : Add Functionality to these variables
  public var bodies   :StringMap<{body:Body,anchor:Vec2}>;
  public var materials:StringMap<Material>;
  public var filters  :StringMap<InteractionFilter>;
  public var fprops   :StringMap<FluidProperties>;
  public var types    :StringMap<CbType>;

  private var _hitboxListener:InteractionListener;
  private var _wallListener:InteractionListener;

  public function new(key:String,?active:Bool=false,?visible:Bool=true) {
    super({
      key: key,
      active: active,
      visible: visible
    });
  }

  public function initspace(gravity:{x:Float,y:Float},?worldLinearDrag:Float=0,?worldAngularDrag:Float=0){
    space = new Space(Vec2.weak(gravity.x, gravity.y));
    space.worldLinearDrag = worldLinearDrag;
    space.worldAngularDrag = worldAngularDrag;
    _hitboxListener = new InteractionListener(CbEvent.BEGIN, InteractionType.ANY, CustomCbTypes.HITBOX, CustomCbTypes.HITBOX, hitboxEvent);
    _wallListener = new InteractionListener(CbEvent.BEGIN, InteractionType.ANY, CustomCbTypes.HITBOX, CustomCbTypes.WALL, wallEvent);
    space.listeners.add(_hitboxListener);
    space.listeners.add(_wallListener);
  }

  private function hitboxEvent(colliding:InteractionCallback){
    trace("HitBox Touch");
    var int1 = colliding.int1.castShape.body.userData.data;
    var int2 = colliding.int2.castShape.body.userData.data;
    if(int1.gameobject!=null)
      {
        var go = int1.gameobject;
        if(go.hitboxEvent!=null){
          Reflect.callMethod(go, go.hitboxEvent, [int2]);
        }
      }
      if(int2.gameobject!=null)
        {
          var go = int2.gameobject;
          if(go.hitboxEvent!=null){
            Reflect.callMethod(go, go.hitboxEvent, [int1]);
          }
        }
  }

  private function wallEvent(colliding:InteractionCallback){
    trace("Wall Touch");
    var int1 = colliding.int1.castShape.body.userData.data;
    if(int1.gameobject!=null)
      {
        var go = int1.gameobject;
        if(go.wallEvent!=null){
          Reflect.callMethod(go, go.wallEvent, []);
        }
      }
  }

  public function step(fps:Float){
    space.step(1/fps);
  }
}