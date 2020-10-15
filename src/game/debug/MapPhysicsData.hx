package game.debug;

import game.physics.CustomCbTypes;
import haxe.ds.StringMap;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Shape;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.geom.Vec2;
import nape.geom.Vec3;
import nape.dynamics.InteractionFilter;
import nape.phys.Material;
import nape.phys.FluidProperties;
import nape.callbacks.CbType;
import nape.callbacks.CbTypeList;
import nape.geom.AABB;

import StringTools;

class MapPhysicsData {
  static var bodies   :StringMap<{body:Body,anchor:Vec2}>;
  static var materials:StringMap<Material>;
  static var filters  :StringMap<InteractionFilter>;
  static var fprops   :StringMap<FluidProperties>;
  static var types    :StringMap<CbType>;
  public static function create_testmap(type:BodyType):Body {
            var colType:CbType = new CbType();
            var bodies = new StringMap<{body:Body,anchor:Vec2}>();
            var body = new Body(type);

            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    var s = new Circle(
                        49.87052363204765,
                        Vec2.weak(437.504971647405,181.81342969806468)
                    );
                    s.body = body;
                    s.sensorEnabled = false;
                    //s.fluidEnabled = false;
                    //s.fluidProperties = prop;
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    var s = new Circle(
                        42.72753099467036,
                        Vec2.weak(737.5083807770545,407.95236309503514)
                    );
                    s.body = body;
                    s.sensorEnabled = false;
                    //s.fluidEnabled = false;
                    //s.fluidProperties = prop;
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    var s = new Circle(
                        39.00183648212801,
                        Vec2.weak(400.00454550619884,560.2268207593269)
                    );
                    s.body = body;
                    s.sensorEnabled = false;
                    //s.fluidEnabled = false;
                    //s.fluidProperties = prop;
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(160,194)   ,  Vec2.weak(207,219)   ,  Vec2.weak(207,169)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(175,123)   ,  Vec2.weak(165,169)   ,  Vec2.weak(194,187)   ,  Vec2.weak(191,153)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(207,169)   ,  Vec2.weak(191,153)   ,  Vec2.weak(194,187)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(207,103)   ,  Vec2.weak(171,103)   ,  Vec2.weak(176,135)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(191,114)   ,  Vec2.weak(249,106)   ,  Vec2.weak(246,74)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(323,98)   ,  Vec2.weak(246,74)   ,  Vec2.weak(249,106)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(372,108)   ,  Vec2.weak(352,75)   ,  Vec2.weak(340,101)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(340,101)   ,  Vec2.weak(352,75)   ,  Vec2.weak(292,98)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(390,139)   ,  Vec2.weak(404,107)   ,  Vec2.weak(379.8999938964844,120)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(404,107)   ,  Vec2.weak(361,103)   ,  Vec2.weak(379.8999938964844,120)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(207,219)   ,  Vec2.weak(191,200)   ,  Vec2.weak(186,226)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(186,226)   ,  Vec2.weak(191,200)   ,  Vec2.weak(160,240)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                        //cbtype(s.cbTypes, "");
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(171,231)   ,  Vec2.weak(139,232)   ,  Vec2.weak(150,250)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(150,250)   ,  Vec2.weak(139,232)   ,  Vec2.weak(139,273)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(420,143)   ,  Vec2.weak(386,127)   ,  Vec2.weak(390,173)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(104,271)   ,  Vec2.weak(118,320)   ,  Vec2.weak(141,268)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(124,306)   ,  Vec2.weak(95,331)   ,  Vec2.weak(114,336)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(114,336)   ,  Vec2.weak(95,331)   ,  Vec2.weak(108,369)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(85,385)   ,  Vec2.weak(101,413)   ,  Vec2.weak(110,355)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(102,403)   ,  Vec2.weak(72,418)   ,  Vec2.weak(82,491)   ,  Vec2.weak(95,441)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(136,520)   ,  Vec2.weak(101,497)   ,  Vec2.weak(68,524)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(68,524)   ,  Vec2.weak(101,497)   ,  Vec2.weak(86,473)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(123,516)   ,  Vec2.weak(147,555)   ,  Vec2.weak(162,528)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(206,537)   ,  Vec2.weak(162,528)   ,  Vec2.weak(147,555)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(182,533)   ,  Vec2.weak(223,568)   ,  Vec2.weak(224,540)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(283,543)   ,  Vec2.weak(224,540)   ,  Vec2.weak(223,568)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(261,547)   ,  Vec2.weak(307,568)   ,  Vec2.weak(298,542)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(377,524)   ,  Vec2.weak(298,542)   ,  Vec2.weak(307,568)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(398,521)   ,  Vec2.weak(374,525)   ,  Vec2.weak(378,547)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(475,539)   ,  Vec2.weak(413,524)   ,  Vec2.weak(429,547)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(537,537)   ,  Vec2.weak(465,537)   ,  Vec2.weak(498,563)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(598,525)   ,  Vec2.weak(525,538)   ,  Vec2.weak(564,560)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(651,498)   ,  Vec2.weak(577,529)   ,  Vec2.weak(625,536)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(684,457)   ,  Vec2.weak(666,482.85713958740234)   ,  Vec2.weak(689,501)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(666,482.85713958740234)   ,  Vec2.weak(646,501)   ,  Vec2.weak(689,501)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(683,464)   ,  Vec2.weak(732,447)   ,  Vec2.weak(692,436)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(695,405)   ,  Vec2.weak(692,436)   ,  Vec2.weak(732,447)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(715,374)   ,  Vec2.weak(778,367)   ,  Vec2.weak(736,349)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(745,327)   ,  Vec2.weak(736,349)   ,  Vec2.weak(778,367)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(745,331)   ,  Vec2.weak(786,284)   ,  Vec2.weak(748,288)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(786,284)   ,  Vec2.weak(737,242)   ,  Vec2.weak(748,288)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(758,211)   ,  Vec2.weak(723,200)   ,  Vec2.weak(741,253)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(757,175)   ,  Vec2.weak(713,153)   ,  Vec2.weak(724,202)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(450,110)   ,  Vec2.weak(485,169)   ,  Vec2.weak(484,142)   ,  Vec2.weak(474,125)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(448,115)   ,  Vec2.weak(490,98)   ,  Vec2.weak(473,82)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(547,83)   ,  Vec2.weak(473,82)   ,  Vec2.weak(490,98)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(605,64)   ,  Vec2.weak(548,57)   ,  Vec2.weak(538,85)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(589,68)   ,  Vec2.weak(617.4285888671875,66.28570556640625)   ,  Vec2.weak(617,43)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(652,69)   ,  Vec2.weak(617,43)   ,  Vec2.weak(617.4285888671875,66.28570556640625)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(674,82)   ,  Vec2.weak(673,53)   ,  Vec2.weak(647,68)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            
                //var mat = material("default");
                //var filt = filter("default");
                //var prop = fprop("default");

                
                    
                        var s = new Polygon(
                            [   Vec2.weak(670,79)   ,  Vec2.weak(707,136)   ,  Vec2.weak(723,77)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                        var s = new Polygon(
                            [   Vec2.weak(715,158)   ,  Vec2.weak(723,77)   ,  Vec2.weak(707,136)   ]
                        );
                        s.body = body;
                        s.sensorEnabled = false;
                        //s.fluidEnabled = false;
                        //s.fluidProperties = prop;
                    
                
            

            var anchor = Vec2.get(0,0);
            body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
            body.position.setxy(0,0);
            body.cbTypes.add(CustomCbTypes.WALL);
            body.userData.data = "wall";
            return body;
            //bodies.set("test_groundmap",{body:body,anchor:anchor});
    }
}
