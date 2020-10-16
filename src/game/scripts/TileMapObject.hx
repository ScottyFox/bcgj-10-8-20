package game.scripts;

import core.textures.Frame;
import core.scene.Scene;
import core.Renderer;
import core.cameras.Camera;
import core.gameobjects.Image;
import core.gameobjects.components.TransformMixin;
import core.gameobjects.GameObject;

class TileMapObject extends GameObject implements TransformMixin{

  private var MapSprite:Image;
  private var testmap:Array<Array<Int>> = [
    [1,1,1,1],
    [1,0,0,1],
    [1,0,0,1],
    [1,1,1,1]
  ];
  private var map_frames:Map<Int, Frame> = new Map();
  private var map_tileSize:{w:Float,h:Float};
  //private var map_data:Array<Int>;

  public function new(scene:Scene, x:Float, y:Float, texture:String) {  
    super(scene,'tilemap');
    MapSprite = new Image(scene,0,0,texture);
    build_mapframes_MAP();
  }

  private function build_mapframes_MAP(){
    map_tileSize = {w:MapSprite.width,h:MapSprite.height};
    for(y in 0...testmap.length){
      for(x in 0...testmap[y].length){
        set_tile(testmap[y][x]);
      }
    }
  }

  private function get_tile(id:Int):Frame{
    return map_frames.get(id);
  }

  private function set_tile(id:Int){
    if(!map_frames.exists(id))
      {
        map_frames.set(id,MapSprite.texture.get(Std.string(id)));
      }
  }

  private function change_tile(id:Int){
    MapSprite.frame = get_tile(id);
  }

  private function render_map(map:Array<Array<Int>>,renderer:Renderer,camera:Camera)
    {
      MapSprite.x = this.x;
      MapSprite.y = this.y;
      for(y in 0...map.length){
        MapSprite.y = y*map_tileSize.h;
        for(x in 0...map[y].length){
          MapSprite.x = x*map_tileSize.w;
          renderer.batchImage(MapSprite, get_tile(map[y][x]), camera);
        }
      }
    }

  override public function render(renderer:Renderer, camera:Camera) {
    render_map(testmap,renderer,camera);
	}
}