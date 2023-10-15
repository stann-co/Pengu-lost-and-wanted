{
  "resourceType": "GMRoom",
  "resourceVersion": "1.0",
  "name": "rm_level1",
  "creationCodeFile": "rooms/rm_parent/RoomCreationCode.gml",
  "inheritCode": false,
  "inheritCreationOrder": false,
  "inheritLayers": false,
  "instanceCreationOrder": [
    {"name":"inst_1636A391_1","path":"rooms/rm_level1/rm_level1.yy",},
    {"name":"inst_482CB2D0","path":"rooms/rm_level1/rm_level1.yy",},
    {"name":"inst_27133DD5","path":"rooms/rm_level1/rm_level1.yy",},
  ],
  "isDnd": false,
  "layers": [
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Instances_A","depth":400,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_1636A391_1","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_pengu","path":"objects/obj_pengu/obj_pengu.yy",},"properties":[],"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":176.0,"y":1040.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_482CB2D0","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_layer_switch","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_layer_switch","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"propertyId":{"name":"only_grounded","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"value":"True",},
          ],"rotation":0.0,"scaleX":5.0,"scaleY":3.0,"x":2168.0,"y":1048.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_27133DD5","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_layer_switch","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_layer_switch","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"propertyId":{"name":"only_grounded","path":"objects/obj_layer_switch/obj_layer_switch.yy",},"value":"False",},
          ],"rotation":0.0,"scaleX":2.0,"scaleY":9.0,"x":2272.0,"y":1096.0,},
      ],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"decor_01_A","depth":500,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[],"properties":[],"tiles":{"SerialiseHeight":0,"SerialiseWidth":0,"TileSerialiseData":[
],},"tilesetId":null,"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"decor_01_B","depth":600,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[],"properties":[],"tiles":{"SerialiseHeight":0,"SerialiseWidth":0,"TileSerialiseData":[
],},"tilesetId":null,"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"collision_A","depth":0,"effectEnabled":true,"effectType":null,"gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"collision_A_oneway","depth":100,"effectEnabled":true,"effectType":"_filter_hue","gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[],"properties":[
            {"name":"g_HueShift","type":0,"value":"0.875",},
            {"name":"g_HueSaturation","type":0,"value":"1",},
          ],"tiles":{"SerialiseHeight":313,"SerialiseWidth":625,"TileCompressedData":[
-1882,-2147483648,-16,0,-609,-2147483648,-16,0,-609,-2147483648,-16,0,-609,-2147483648,-16,0,-609,-2147483648,-16,0,-609,-2147483648,-16,0,-609,-2147483648,-16,0,-609,-2147483648,-16,0,-609,-2147483648,-16,0,-609,-2147483648,-16,0,-188102,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collisions","path":"tilesets/ts_collisions/ts_collisions.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
      ],"properties":[],"tiles":{"SerialiseHeight":313,"SerialiseWidth":625,"TileCompressedData":[
-1880,-2147483648,-19,0,-606,-2147483648,-19,0,-606,-2147483648,-19,0,-606,-2147483648,-19,0,-606,-2147483648,-19,0,-606,-2147483648,-19,0,-606,-2147483648,-19,0,-606,-2147483648,-19,0,-606,-2147483648,-19,0,-188726,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collisions","path":"tilesets/ts_collisions/ts_collisions.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
    {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"collision_B","depth":200,"effectEnabled":true,"effectType":"_filter_hue","gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[
        {"resourceType":"GMRTileLayer","resourceVersion":"1.1","name":"collision_B_oneway","depth":300,"effectEnabled":true,"effectType":"_filter_hue","gridX":16,"gridY":16,"hierarchyFrozen":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":false,"layers":[],"properties":[
            {"name":"g_HueShift","type":0,"value":"0.425",},
            {"name":"g_HueSaturation","type":0,"value":"1",},
          ],"tiles":{"SerialiseHeight":313,"SerialiseWidth":625,"TileCompressedData":[
-1263,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-611,-2147483648,-14,0,-186848,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collisions","path":"tilesets/ts_collisions/ts_collisions.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
      ],"properties":[
        {"name":"g_HueShift","type":0,"value":"0.5",},
        {"name":"g_HueSaturation","type":0,"value":"1",},
      ],"tiles":{"SerialiseHeight":313,"SerialiseWidth":625,"TileCompressedData":[
-1262,-2147483648,-15,0,-610,-2147483648,-15,0,-610,-2147483648,-15,0,-610,-2147483648,-15,0,-610,-2147483648,-15,0,-610,-2147483648,-15,0,-610,-2147483648,-15,0,-610,-2147483648,-15,0,-610,-2147483648,-15,0,-610,-2147483648,-15,0,-188723,-2147483648,],"TileDataFormat":1,},"tilesetId":{"name":"ts_collisions","path":"tilesets/ts_collisions/ts_collisions.yy",},"userdefinedDepth":false,"visible":true,"x":0,"y":0,},
    {"resourceType":"GMRBackgroundLayer","resourceVersion":"1.0","name":"Background","animationFPS":15.0,"animationSpeedType":0,"colour":4287726967,"depth":1100,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"hspeed":0.0,"htiled":false,"inheritLayerDepth":true,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"spriteId":null,"stretch":false,"userdefinedAnimFPS":false,"userdefinedDepth":false,"visible":true,"vspeed":0.0,"vtiled":false,"x":0,"y":0,},
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