package game.scripts;

import core.scene.Scene;
import haxe.ds.Vector;
import core.gameobjects.components.TransformMixin;
import core.gameobjects.GameObject;



class RailsObject extends GameObject implements TransformMixin{
  //Points of Rail.
  private var _points:Array<RailPoint> = new Array<RailPoint>();
  //Current Point Of Animation;
  private var _currentPoint:Int = 0;
  //Total Duration of Rail Animation
  private var _totalduration:Float = 0;
  //Current Delta of Rail Animation
  private var _currentdelta:Float = 0;
  //Is Animation Playing?
  private var _playing:Bool = false;
  //Is Animation Looping?
  private var _looping:Bool = false;

  //To-Do Ping Pong Animation?

  public function new(scene:Scene, x:Float, y:Float) {  
    super(scene,'rail');
    }

  //Resets Points Array
  public function clearPoints(){
      _totalduration = 0;
      _currentdelta = 0;
      _currentPoint = 0;
      _points = new Array<RailPoint>();
    }

  //Adds Points From Array
  public function addPoints(points:Array<{x:Float,y:Float,d:Float}>){
    for(p in points){
    addPoint(p);
    }
  }

  //Adds Point , Returns Index of Point
  public function addPoint(point:{x:Float,y:Float,d:Float}):Int{
    //new index of point
    var index = _points.length;
    _points.push(cast {x:point.x,y:point.y,duration:point.d});

    //If new point, Update Position
    if(_points.length==1)
      {
        this.x = point.x;
        this.y = point.y;
        _points[index].edelta = 0;
      }else{
      //add duration of last point, since it has a neighbor now.
      _totalduration += _points[index-1].duration;
      //sets difference of last point, used for Animation.
      _points[index-1].difference ={
        x:point.x-_points[index-1].x,
        y:point.y-_points[index-1].y
      }
      //sets elapsed delta from last point and adds its duration.
      _points[index].edelta = _points[index-1].edelta + _points[index-1].duration;
      }
      
    return index;
  }

  //Removes Point To-Do : offset animation when removed is current Point
  public function removePoint(index:Int){
    var removed = _points.splice(index, 1)[0];
    //checks if last point in array.
    if(index==_points.length)
      {
        //remove duration from total
        _totalduration -= removed.duration;
      }else{
        //re-set elapsed deltas.
        for (i in 1..._points.length){
        _points[i].edelta = _points[i-1].edelta + _points[i-1].duration;
        }
      }
    }
  
  //Set Looping
  public function setLooping(looping:Bool){
    _looping = looping;
    }

  //Plays Rail Animation
  public function play(){
      _playing = true;
    }

  //Stops Rail Animation
  public function stop(){
      _playing = false;
    }

  //Returns Index of Current Point based off delta. Used for animations that loop.
  private function getCurrentPoint(delta:Float):Int
    {
    var edelta:Float = 0;
    for (i in 0..._points.length){
      edelta += _points[i].duration;
      if(edelta>delta)
        {
          return i;
        }
    }
    //This should never happen.
    return _points.length-1;
    }

  //Sets this position from Point
  private function setPositionFromPoint(index:Int,ratio:Float)
    {
      if(ratio==0)
        {
          this.x = _points[index].x;
          this.y = _points[index].y;
        }else{
          this.x = _points[index].x + _points[index].difference.x * ratio;
          this.y = _points[index].y + _points[index].difference.y * ratio;
        }
    }

  override public function preUpdate(time:Float, delta:Float){
  if(_points.length>1&&_playing)
    {
      _currentdelta+=delta;

      if(_currentdelta>_totalduration){
        //Check if looping.
        if(_looping){
          //offset the difference in currentdelta.
          _currentdelta -= _totalduration * Math.floor(_currentdelta/_totalduration);
          //set point to 0, so it can be checked later in loop.
          _currentPoint = 0;
        }else{
        //Not looping, Stopping.
          _currentPoint = _points.length-1;
          setPositionFromPoint(_currentPoint,0);
          stop();
        }
        }

      //if still playing, assume current delta is less than total duration.
      if(_playing){
        //just skip to last point
        if(_currentdelta==_totalduration)
          {
            _currentPoint = _points.length-1;
          }else{
            //loop to go through each point if edelta is exceeded.
            while(_currentdelta>_points[_currentPoint].edelta+_points[_currentPoint].duration)
              {
                _currentPoint++;
              }
          }
        var ratio = (_currentdelta - _points[_currentPoint].edelta)/_points[_currentPoint].duration;
        setPositionFromPoint(_currentPoint,ratio);
        }
    }
  }

}

typedef RailPoint = {
  public var x : Float;
  public var y : Float;
  public var duration : Float;
  public var difference:{x:Float,y:Float};
  public var edelta : Float;
}