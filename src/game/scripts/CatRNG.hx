package game.scripts;

class CatRNG{
  static public function random(seed:Int, count:Int):Float
  {
    var index = (count + 1) % 624;
    
    var MT = new Array<Int>();
		MT[624 - 1] = 0;
		MT[0] = seed;
    for (i in 1...624) MT[i] = 0x6c078965 * (MT[i - 1] ^ (MT[i - 1] >> 30)) + i;

		var y: Int = MT[index];
		y = y ^ (y >> 11);
		y = y ^ ((y << 7) & (0x9d2c5680));
		y = y ^ ((y << 15) & (0xefc60000));
    y = y ^ (y >> 18);
    
		return y / 0x7ffffffe;
  }

  static public function randomDVect(seed:Int,x1:Int,y1:Int):Float
  {
    var index = ((x1<0 ? x1+0x3FFFFFFF : x1) + 1) % 624;
    
    var MT = new Array<Int>();
		MT[624 - 1] = 0;
		MT[0] = seed^(y1<0 ? y1+0x3FFFFFFF : y1);
    for (i in 1...624) MT[i] = 0x6c078965 * (MT[i - 1] ^ (MT[i - 1] >> 30)) + i;

    var b: Int =  MT[index];
		b = b ^ (b >> 11);
    b = b ^ ((b << 7) & (0x9d2c5680));
		b = b ^ ((b << 15) & (0xefc60000));
    b = b ^ (b >> 18);
    
		return b / 0x7ffffffe;
  }

  static public function randomVect(seed:Int,x1:Int,y1:Int):Float
    {
      var index = (x1 + 1) % 624;
      
      var MT = new Array<Int>();
      MT[624 - 1] = 0;
      MT[0] = seed^y1;
      for (i in 1...624) MT[i] = 0x6c078965 * (MT[i - 1] ^ (MT[i - 1] >> 30)) + i;
  
      var b: Int =  MT[index];
      b = b ^ (b >> 11);
      b = b ^ ((b << 7) & (0x9d2c5680));
      b = b ^ ((b << 15) & (0xefc60000));
      b = b ^ (b >> 18);
      
      return b / 0x7ffffffe;
    }
}