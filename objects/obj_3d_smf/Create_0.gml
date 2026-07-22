model = smf_model_load("3D/pengu_mech.smf");
inst = new smf_instance(model);
inst.play("walk",.02,1,true);

rotx = 0;
roty = 0;
rotz = 0;

offset = 0;

index_offset = 0;

Inspectron()
    .Section("angle")
    .SliderInt("rotx",-360,360)
    .SliderInt("roty",-360,360)
    .SliderInt("rotz",-360,360)

    .SliderInt("offset",-32,32)

    .SliderInt("index_offset",-3,3)
.render()

matInv = array_create(16)