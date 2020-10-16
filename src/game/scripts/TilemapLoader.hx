package game.scripts;

import kha.Image;
import haxe.io.Bytes;
import haxe.ds.Vector;
import kha.Assets;

class TilemapLoader{

  static public function getMapData(image:String,data:Array<Int>,buildfunction:Vector<Vector<Int>>->Void)
    {
      Assets.loadImage(image,function (image:Image) {
        if(image!=null){
          buildMapData(image,data,buildfunction);
        }else{
          trace("Woops image doesnt exist");
        }
      });
    }

  static public function buildMapData(image:Image,data:Array<Int>,buildfunction:Vector<Vector<Int>>->Void)
    {
    var newmap = new Vector<Vector<Int>>(image.height);
    for (i in 0...newmap.length){
      newmap[i] = new Vector<Int>(image.width);
      }
    for(y in 0...newmap.length)
      {
        for(x in 0...newmap[y].length)
          {
            var id:Int = null;
            for(pi in 0...data.length)
              {
                if(data[pi]==image.at(x,y).value)
                  {
                    id = pi;
                    break;
                  }
              }
            newmap[y][x] = id;
          }
      }
      buildfunction(newmap);
    }
}