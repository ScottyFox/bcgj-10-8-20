package game.scripts;

import core.gameobjects.GameObject;
import core.textures.Frame;
import core.cameras.Camera;
import core.Renderer;
import core.scene.Scene;
import core.gameobjects.Image;
import haxe.ds.Vector;

//A single module for scenes to handle and manage tilemaps.
class TilemapModule extends GameObject{
  //slave Image used to draw tiles.
  private var _tileBrush:Image;
  //assumed tilesize based off slave image size.
  //To-Do : Something more managed, like handling own texture.
  private var _tileSize:{w:Float,h:Float};
  //tileset frame data, loosely held, but should be okay.
  //tile ID is map data directly, 0, 1, 2, for example
  //will pull the index of this array
  private var _tileFrames:Array<Frame> = new Array();
  //default frame for empty space, null
  private var _tileDefault:Int;

  //"chunks" of data used for map rendering. Can be modified in runtime.
  private var _chunkMap:Map<String,Vector<Vector<Int>>> = new Map();
  //chunk size used for generating new chunks, do not change during runtime.
  private var _chunkSize:{w:Int,h:Int};
  //real chunk size based off tilesize, used for calculating rendering.
  private var _chunkRealSize:{w:Float,h:Float};

  //used for rendering.
  private var _mapOffset:{x:Float,y:Float};

  //frames would be handled like ["0","1"], or what ever the frame is called.
  //default frame is the index of the frames defined.
  public function new(scene:Scene,x:Float,y:Float, tilesetTexture:String, chunksize:{width:Int,height:Int}, ?frames:Array<String> ,?defaultFrame:Int=0) { 
  super(scene,'tilemap');
  _mapOffset = {x:x,y:y};
  _tileBrush = new Image(scene,0,0,tilesetTexture);
  _tileSize = {w:_tileBrush.width,h:_tileBrush.height};
  setTileFrames(frames);
  _tileDefault = defaultFrame;
  _chunkSize = {w:chunksize.width,h:chunksize.height};
  setChunkSize(chunksize.width,chunksize.height);
  }

  public function loadMapData(data:Vector<Vector<Int>>)
  {
    //makesure data isnt empty..
    if(data.length>0&&data[0].length>0){
    var chunkw:Int = Math.ceil(data[0].length / _chunkSize.w);
    var chunkh:Int = Math.ceil(data.length / _chunkSize.h);
    trace("Map Width: "+chunkw+" Height :"+chunkh);
    var chunkid:String;
    for(cy in 0...chunkh){
      for(cx in 0...chunkw){
        chunkid = getChunkID(cx,cy);
        addChunk(chunkid);
        var chunk = _chunkMap.get(chunkid);
        var rx:Int;
        var ry:Int;
        for(y in 0...chunk.length){
          ry = y + (_chunkSize.h*cy);
          if(data.length<=ry)
          break;
          for(x in 0...chunk[y].length){
            rx = x + (_chunkSize.w*cx);
            if(data[ry].length<=rx)
            break;
            chunk[y][x] = data[ry][rx];
            }
          }
        }
      }
      trace("Map Loaded");
    }else{
    trace("Couldn't Load Tilemap Data!!! Data Empty?");
    }
  }

  //set frames for tile ids
  private function setTileFrames(frames:Array<String>){
  for(fid in frames){
    _tileFrames.push(_tileBrush.texture.get(fid));
    }
  }

  //gets frame for id
  private function getTileFrame(id:Int):Frame{
  if(id==null){
    id = _tileDefault;
  }
  if(id>_tileFrames.length){
    if(_tileFrames.length==0)
      _tileFrames.push(_tileBrush.texture.get(Std.string(id)));
    }
  return _tileFrames[id];
  }

  //returns chunk
  private function getChunkID(x:Int,y:Int):String{
  return x+":"+y;
  }

  //This should only run once. Otherwise weirdness may occure.
  private function setChunkSize(width:Int,height:Int){
  _chunkSize = {w:width,h:height};
  _chunkRealSize = {w:_tileSize.w * width,h:_tileSize.h * height};
  }

  //adds a new chunk.
  private function addChunk(chunkid:String,?data:Vector<Vector<Int>>):Bool{
  var chunkcreated:Bool = false;
  if(!_chunkMap.exists(chunkid)){
    if(data!=null){
      _chunkMap.set(chunkid,data);
      }
    else{
      var newchunk:Vector<Vector<Int>> = new Vector<Vector<Int>>(_chunkSize.h);
      for (i in 0...newchunk.length){
        newchunk[i] = new Vector<Int>(_chunkSize.w);
        }
      _chunkMap.set(chunkid,newchunk);
      }
    chunkcreated = true;
    }
  return chunkcreated; //sorry my instructor always told me to only have 1 exit point in college, it's a habit.
  }

  //draws tiles with map data
  private function drawTiles(xoffset:Float,yoffset:Float,map:Vector<Vector<Int>>,renderer:Renderer,camera:Camera){
  _tileBrush.y = _mapOffset.y + yoffset;
  for(y in 0...map.length){
    _tileBrush.x = _mapOffset.x + xoffset;
    for(x in 0...map[y].length){
      renderer.batchImage(_tileBrush, getTileFrame(map[y][x]), camera);
      _tileBrush.x += _tileSize.w;
      }
      _tileBrush.y += _tileSize.h;
    }
  }

  //draws tiles with tile id
  private function drawFillTiles(xoffset:Float,yoffset:Float,tileID:Int,renderer:Renderer,camera:Camera){
  _tileBrush.y = _mapOffset.y + yoffset;
  for(y in 0..._chunkSize.h){
    _tileBrush.x = _mapOffset.x + xoffset;
    for(x in 0..._chunkSize.w){
      renderer.batchImage(_tileBrush, getTileFrame(tileID), camera);
      _tileBrush.x += _tileSize.w;
      }
    _tileBrush.y += _tileSize.h;
    }
  }

  //renders tiles in visible chunks
  public function render_chunks(renderer:Renderer, camera:Camera){
  //First visible chunks
  var chunkx:Int = Math.floor(camera.scrollX / _chunkRealSize.w);
  var chunky:Int = Math.floor(camera.scrollY / _chunkRealSize.h);

  //Amount of chunks visible.
  var chunkw:Int = Math.ceil(camera.width / _chunkRealSize.w)+1;
  var chunkh:Int = Math.ceil(camera.height / _chunkRealSize.h)+1;

  var chunkid:String;
  for(y in 0...chunkh){
    var yoffset = _mapOffset.y + ( (chunky + y ) * _chunkRealSize.h);
    for(x in 0...chunkw){
      chunkid = getChunkID(chunkx + x,chunky + y);
      var xoffset = _mapOffset.x + ( (chunkx + x ) * _chunkRealSize.w );
      if(_chunkMap.exists(chunkid)){
        drawTiles(xoffset,yoffset,_chunkMap.get(chunkid),renderer,camera);
        }else{
        drawFillTiles(xoffset,yoffset,_tileDefault,renderer,camera);
        }
      }
    }
  }

  override public function render(renderer:Renderer, camera:Camera) {
    render_chunks(renderer,camera);
	}

}