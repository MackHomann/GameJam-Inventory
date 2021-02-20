/// @description
#region INFO
/*
 
*/
#endregion
sprite_index = ID;
s ++;

if (pickup) {
	x = lerp(x, picker.x, 1/7);
	y = lerp(y, picker.y, 1/7);
	image_xscale = lerp(image_xscale, 0, 1/7);
	image_yscale = lerp(image_yscale, 0, 1/7);
} else {
	/*
		Here goes your collision code, 
		if u have a parent object for collision just use event_inherited();
	*/
}

if (image_yscale < 0.02) {
	instance_destroy();	
}