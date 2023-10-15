{
  "resourceType": "GMRoom",
  "resourceVersion": "1.0",
  "name": "rm_test",
  "creationCodeFile": "rooms/rm_test/RoomCreationCode.gml",
  "inheritCode": false,
  "inheritCreationOrder": false,
  "inheritLayers": false,
  "instanceCreationOrder": [
    {"name":"inst_1636A391","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_46C0378B","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_173BA35A","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_2C40FBBD","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_515249D1","path":"rooms/rm_test/rm_test.yy",},
  ],
  "isDnd": false,
  "layers": [
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Instances_A","depth":400,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_1636A391","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_pengu","path":"objects/obj_pengu/obj_pengu.yy",},"properties":[],"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":192.0,"y":192.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_46C0378B","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_layer_switch","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_layer_switch","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"propertyId":{"name":"only_grounded","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"value":"True",},
          ],"rotation":0.0,"scaleX":3.0,"scaleY":2.0,"x":616.0,"y":80.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_173BA35A","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_layer_switch","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"properties":[],"rotation":0.0,"scaleX":6.0,"scaleY":5.0,"x":752.0,"y":168.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_2C40FBBD","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_enemy_toybot","path":"objects/obj_enemy_toybot/obj_enemy_toybot.yy",},"properties":[],"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":313.0,"y":206.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_515249D1","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_depth_set","path":"objects/obj_depth_set/obj_depth_set.yy",},"properties":[],"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":131.0,"y":150.0,},
      ],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"decor_01_A","depth":500,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[],"properties":[],"tiles":{"SerialiseHeight":0,"SerialiseWidth":0,"TileSerialiseData":[
],},"tilesetId":null,"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"decor_01_B","depth":600,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[],"properties":[],"tiles":{"SerialiseHeight":0,"SerialiseWidth":0,"TileSerialiseData":[
],},"tilesetId":null,"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"collision_A","depth":0,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"collision_A_oneway","depth":100,"effectEnabled":true,"effectType":"_filter_hue","gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[],"properties":[
            {"name":"g_HueShift","type":0,"value":"0.875",},
            {"name":"g_HueSaturation","type":0,"value":"1",},
          ],"tiles":{"SerialiseHeight":15,"SerialiseWidth":27,"TileCompressedData":[
-88,-2147483648,-16,0,-11,-2147483648,-16,0,-11,-2147483648,-16,0,-11,-2147483648,-16,0,-11,-2147483648,-16,0,-11,-2147483648,-16,0,-11,-2147483648,-16,
0,-11,-2147483648,-16,0,-11,-2147483648,-16,0,-11,-2147483648,-16,0,-58,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collisions","path":"tilesets/ts_collisions/ts_collisions.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
      ],"properties":[],"tiles":{"SerialiseHeight":19,"SerialiseWidth":82,"TileCompressedData":[
-3,1,-7,1342177281,-7,1879048193,-9,1,1,0,-55,-2147483648,-3,1,-7,1342177281,-7,1879048193,-9,1,-2,0,1,-2147483648,-18,0,-35,-2147483648,-15,1,-2,1879048193,-3,805306369,-6,1,-21,0,-3,-2147483648,-5,0,-27,-2147483648,-15,1,-2,1879048193,-3,805306369,-2,1,-4,805306369,-2,0,1,-2147483648,-9,0,6,536870913,805306369,536870913,536870913,805306369,805306369,-11,0,-27,-2147483648,-22,1,-3,805306369,4,1342177291,0,0,-2147483648,-10,0,
5,536870933,536870934,536870935,536870913,536870913,-11,0,-27,-2147483648,-22,1,-3,805306369,1,1342177290,-15,0,3,536870932,1879048215,536870913,-7,0,2,-2147483648,0,-29,-2147483648,-3,1,-6,1342177281,-13,1,4,805306369,805306379,805306378,805306377,-16,0,2,1879048214,536870913,-7,0,-31,-2147483648,-3,1,-2,1342177281,3,1342177294,805306381,805306380,-34,0,2,1879048213,536870913,-3,0,1,-2147483648,-3,0,-31,-2147483648,-3,1,3,268435457,1342177281,1342177293,-21,0,-2,1,-14,0,
1,536870913,-3,0,1,-2147483648,-13,0,-21,-2147483648,-3,1,3,268435457,1342177281,1342177292,-21,0,-2,1,-13,0,2,1610612757,1,-6,0,-10,1,-4,805306369,-18,-2147483648,-3,1,3,268435457,1342177281,1073741836,-21,0,-2,1,-13,0,2,1610612758,1,-5,0,1,1610612748,-10,1,-3,805306369,1,1342177291,-18,-2147483648,-3,1,-2,268435457,1,1073741837,-21,0,-2,1,-12,0,3,20,1610612759,1,-5,0,1,1610612749,-10,1,
-3,805306369,1,1342177290,-18,-2147483648,-3,1,-2,268435457,3,268435470,268435469,268435468,-19,0,-2,1,-10,0,5,21,22,23,1,1,-3,0,3,12,13,14,-10,1,4,805306369,805306379,805306378,805306377,-18,-2147483648,-3,1,-5,268435457,-2,1,1,268435457,-3,1,1,268435459,-8,15,1,3,-15,1,3,268435457,1,1,-3,268435457,-15,1,1,0,-21,-2147483648,-3,1,-4,268435457,-3,1,1,268435457,-3,1,-2,
268435457,-44,1,1,0,-21,-2147483648,-60,1,1,0,-21,-2147483648,-60,1,1,0,-21,-2147483648,-60,1,1,0,-103,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collisions","path":"tilesets/ts_collisions/ts_collisions.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"collision_B","depth":200,"effectEnabled":true,"effectType":"_filter_hue","gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":false,"inheritVisibility":false,"layers":[
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"collision_B_oneway","depth":300,"effectEnabled":true,"effectType":"_filter_hue","gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[],"properties":[
            {"name":"g_HueShift","type":0,"value":"0.425",},
            {"name":"g_HueSaturation","type":0,"value":"1",},
          ],"tiles":{"SerialiseHeight":15,"SerialiseWidth":27,"TileCompressedData":[
-67,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,
0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,-13,-2147483648,-14,0,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collisions","path":"tilesets/ts_collisions/ts_collisions.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
        {"resourceType":"GMRBackgroundLayer","resourceVersion":"1.0","name":"Backgrounds_1","animationFPS":15.0,"animationSpeedType":0,"colour":4282202164,"depth":1100,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"hspeed":0.0,"htiled":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"spriteId":null,"stretch":false,"userdefinedAnimFPS":false,"userdefinedDepth":false,"visible":true,"vspeed":0.0,"vtiled":false,"x":0,"y":0,},
      ],"properties":[
        {"name":"g_HueShift","type":0,"value":"0.5",},
        {"name":"g_HueSaturation","type":0,"value":"1",},
      ],"tiles":{"SerialiseHeight":19,"SerialiseWidth":82,"TileCompressedData":[
-279,-2147483648,1,1073741825,-5,1342177281,1,1,-75,-2147483648,7,1073741825,1342177281,805306391,805306390,805306389,-2147483648,536870933,-75,-2147483648,3,1342177281,1342177303,1342177300,-79,-2147483648,2,1342177281,1342177302,-80,-2147483648,2,1073741825,1342177301,-80,-2147483648,1,268435457,-78,-2147483648,-3,0,2,268435457,1073741845,-15,-2147483648,1,1,-61,-2147483648,-2,0,3,-2147483648,268435457,1073741846,-14,-2147483648,2,1610612748,1,-60,-2147483648,-3,0,4,-2147483648,268435457,1073741847,268435476,-13,-2147483648,2,1610612749,1,-64,-2147483648,-2,268435457,3,268435479,
268435478,268435477,-9,-2147483648,4,12,13,1610612750,1,-64,-2147483648,-2,1,-2,268435457,2,1,268435457,-12,1,-441,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collisions","path":"tilesets/ts_collisions/ts_collisions.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
  ],
  "parent": {
    "name": "Rooms",
    "path": "folders/Rooms.yy",
  },
  "parentRoom": null,
  "physicsSettings": {
    "inheritPhysicsSettings": false,
    "PhysicsWorld": false,
    "PhysicsWorldGravityX": 0.0,
    "PhysicsWorldGravityY": 10.0,
    "PhysicsWorldPixToMetres": 0.1,
  },
  "roomSettings": {
    "Height": 5000,
    "inheritRoomSettings": false,
    "persistent": false,
    "Width": 10000,
  },
  "sequenceId": null,
  "views": [
    {"hborder":32,"hport":240,"hspeed":-1,"hview":240,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":420,"wview":420,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":240,"hspeed":-1,"hview":240,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":420,"wview":420,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":240,"hspeed":-1,"hview":240,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":420,"wview":420,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":240,"hspeed":-1,"hview":240,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":420,"wview":420,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":240,"hspeed":-1,"hview":240,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":420,"wview":420,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":240,"hspeed":-1,"hview":240,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":420,"wview":420,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":240,"hspeed":-1,"hview":240,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":420,"wview":420,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":240,"hspeed":-1,"hview":240,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":420,"wview":420,"xport":0,"xview":0,"yport":0,"yview":0,},
  ],
  "viewSettings": {
    "clearDisplayBuffer": true,
    "clearViewBackground": false,
    "enableViews": false,
    "inheritViewSettings": false,
  },
  "volume": 1.0,
}