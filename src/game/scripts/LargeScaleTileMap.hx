package game.scripts;
import kha.Assets;
import kha.Font;
import kha.Scheduler;
import haxe.ds.Vector;
import core.textures.Frame;
import core.scene.Scene;
import core.Renderer;
import core.cameras.Camera;
import core.gameobjects.Image;
import core.gameobjects.components.TransformMixin;
import core.gameobjects.GameObject;

class LargeScaleTileMap extends GameObject implements TransformMixin{

  //Slave Image GameObject used for rendering 
  //To-Do : manage own Texture in future.
  private var MapSprite:Image;

  //tileset frame data, loosely held, but should be okay.
  //tile ID is map data directly, 0, 1, 2, for example
  //will pull the index of this array
  private var tile_frames:Array<Frame> = new Array();

  //Vectors and Maps should be accessed [y][x], 
  //for the classic topleft to bottomright access, 
  //For Example =
  //[1,1,1,1] y:1
  //[1,0,0,1] y:2
  //[1,0,0,1] y:3
  //[1,1,1,1] y:4
  //where each y array contains x values.

  //"chunks" of data used for map rendering. Can be modified in runtime.
  private var chunks:Map<String,Vector<Vector<Int>>> = new Map();
  private var chunksize:{w:Int,h:Int};
  private var map_Size:{w:Float,h:Float};
  private var map_tileSize:{w:Float,h:Float};
  //DEBUG
  private var font:Font;
  private var fontloaded:Bool = false;
  private var previousRealTime:Float;
  private var realTime:Float;
  private var seenchunks:Int;


  public function new(scene:Scene, x:Float, y:Float, texture:String,chunksize:{width:Int,height:Int},?frames:Array<String>) {  
    super(scene,'tilemap');
    //Create Image Slave.
    MapSprite = new Image(scene,0,0,texture);
    //sMapSprite.setAlpha(0.5);
    map_tileSize = {w:MapSprite.width,h:MapSprite.height};
    //check if optional frames exist.
    if(frames!=null){
        set_tileframes(frames);
      }
    //Set Chunk Size.
    setChunkSize(chunksize.width,chunksize.height);
    //Debugging
    Assets.loadFont("OpenSans_Regular", setFontLoaded);
  }

  private function setFontLoaded(f:Font){
    font = f;
    fontloaded = true;
  }

  //set frames for tile ids
  private function set_tileframes(frames:Array<String>){
    for(fid in frames)
    {
      tile_frames.push(MapSprite.texture.get(fid));
    }
  }

  //returns frame for tile id, generates default frame if doesn't exist.
  private function get_tile(id:Int):Frame{
    if(id>tile_frames.length)
      {
        if(tile_frames.length==0)
        tile_frames.push(MapSprite.texture.get(Std.string(id)));
      }
    return tile_frames[id];
  }

  private function chid(x:Int,y:Int):String{
    return x+":"+y;
  }

  //This should only run once. Otherwise weirdness may occure.
  private function setChunkSize(width:Int,height:Int){
    chunksize = {w:width,h:height};
    map_Size = {w:map_tileSize.w * width,h:map_tileSize.h * height};
  }

  //adds a new chunk.
  public function addNewChunk(x:Int,y:Int,?data:Vector<Vector<Int>>):Bool{
    var chunkid = chid(x,y);
    var chunkcreated:Bool = false;
    if(!chunks.exists(chunkid)){
      if(data!=null){
        chunks.set(chunkid,data);
      }
      else{
        var newchunk:Vector<Vector<Int>> = new Vector<Vector<Int>>(chunksize.h);
        for (i in 0...newchunk.length) {
          newchunk[i] = new Vector<Int>(chunksize.w);
        }
        chunks.set(chunkid,newchunk);
      }
      chunkcreated = true;
    }
    return chunkcreated; //sorry my instructor always told me to only have 1 exit point in college, it's a habit.
  }

  private function build_tempchunk(chunkid:String){
    var newchunk:Vector<Vector<Int>> = new Vector<Vector<Int>>(chunksize.h);
    for (i in 0...newchunk.length) {
      newchunk[i] = new Vector<Int>(chunksize.w);
      if(i==0||i==newchunk.length-1)
        {
          for (a in 0...newchunk[i].length){
            newchunk[i][a] = 1;
          }
        }else{
          for (a in 0...newchunk[i].length){
            if(a==0||a==newchunk[i].length-1)
              {
                newchunk[i][a] = 1;
              }else{
                newchunk[i][a] = Math.round(Math.random());
              }
          }
        }
    }
    chunks.set(chunkid,newchunk);
  }

  private function render_chunks(renderer:Renderer,camera:Camera){
    var cam_chunkx:Int = Math.floor(camera.scrollX / map_Size.w);
    var cam_chunky:Int = Math.floor(camera.scrollY / map_Size.h);
    var chunk_xcount:Int = Math.ceil(camera.width / map_Size.w)+1;//padding?...
    var chunk_ycount:Int = Math.ceil(camera.height / map_Size.h)+1;
    seenchunks = chunk_xcount*chunk_ycount;
    for(y in 0...chunk_ycount){
      var y_offset = this.y + ( (cam_chunky + y ) * map_Size.h);
      for(x in 0...chunk_xcount){
        var chunkid = chid(cam_chunkx + x,cam_chunky + y);
        var x_offset = this.y + ( (cam_chunkx + x ) * map_Size.h );
        if(chunks.exists(chunkid))
          {
            render_map(x_offset,y_offset,chunks.get(chunkid),renderer,camera);
          }else{
            //DEBUG
            trace("chunk doesnt exist",chunkid);
            build_tempchunk(chunkid);
            render_map(x_offset,y_offset,chunks.get(chunkid),renderer,camera);
          }
      }
    }
  }

  private function render_map(offset_x:Float,offset_y:Float,map:Vector<Vector<Int>>,renderer:Renderer,camera:Camera)
    {
      MapSprite.y = this.y + offset_y;
      for(y in 0...map.length){
        MapSprite.x = this.x + offset_x;
        for(x in 0...map[y].length){
          var hue:Int = Math.floor(255 * CatRNG.randomVect(123,Math.floor(MapSprite.x/map_tileSize.w),Math.floor(MapSprite.y/map_tileSize.h)));
          renderer.graphics.color = kha.Color.fromBytes(hue,hue, hue,255);
          renderer.batchImage(MapSprite, get_tile(map[y][x]), camera);
          MapSprite.x += map_tileSize.w;
        }
        MapSprite.y += map_tileSize.h;
      }
    }

  override public function render(renderer:Renderer, camera:Camera) {
    render_chunks(renderer,camera);
    if(fontloaded){
    renderer.graphics.color = kha.Color.White;
    renderer.graphics.font = font;
    renderer.graphics.fontSize = 24;
    var l = 0;
    for (i in chunks.keys()) {
      l++;
      }

      previousRealTime = realTime;
      realTime = Scheduler.realTime();
      var fps = Math.floor(1.0 / ( realTime - previousRealTime ));
      renderer.graphics.drawString('Number of Chunks Generated: '+l, 2, 2);
      renderer.graphics.drawString('Rendered Chunks: '+seenchunks, 2, 26);
      renderer.graphics.drawString('fps : '+fps, 2, 50);
      
    }
    
	}
}