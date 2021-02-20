/// @description
#region INFO
/*
 
*/
#endregion
if (ID != -1) {
draw_sprite_ext(ID, 
				image_index, 
				x, y + (((sin(s / 20)) * 2) * !pickup),
				image_xscale, image_yscale, 
				0, 
				c_white, 1);	
} else {
	instance_destroy();
	show_debug_message("Item deleted as it has no id")
}