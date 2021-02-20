/// @description
#region INFO
/*
 
*/
#endregion

ID			 = -1;

s			 = irandom(99999);		//used for sin bounce
image_xscale = choose(1, -1);		//randomly flips the item sprite
pickup		 = false;				//boolean checks if this item is picked up
picker		 = -1;					//object that has picked up this item id

#region item ids
	enum item {
		/*
		flint = s_item_flint,		//Exsample on how to add items to the item list
		stone = s_item_stone
		*/
	}
#endregion

//Used when the item has been added to an invetory
function try_pickup(id) {
	if (!pickup and inv_add_item(other.id, ID)) {
		picker = other.id;
		pickup = true;
	}
}