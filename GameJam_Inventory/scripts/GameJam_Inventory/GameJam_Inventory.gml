//V1.0
//Used in item_get_name();
#macro ITEM_PREFIX "s_item_"

//Adds inventory to object that script is called in
function inventory_create(Size) {
	inventory = ds_grid_create(2, Size);
	ds_grid_clear(inventory, -1);
}

//Adds wallet to object that script is called in
function wallet_create() {
	wallet = 0;
}

//Checks if target object has a inventory
function has_inv(_id) {
	return(variable_instance_exists(_id, "inventory"))	
}

//Checks if target object has a wallet
function has_wallet(_id) {
	return(variable_instance_exists(_id, "wallet"))		
}

//Will return the size of tarets inventory
function inventory_size(_id) {
	return(ds_grid_height(_id.inventory));
}

//Will 'dump' inventory and create all items from target objects inventory 
function inventory_dump() {
	var i = 0;
	repeat (ds_grid_height(inventory)) {
		if (inventory[# inv.id, i] != -1) {
			repeat(inventory[# inv.count, i]) {
				create_item((inventory[# inv.id, i]), id, true, 0, 0);
				inv_has_item(id, inventory[# inv.id, i], true, 1);
			}
		}
		i++;
	}
}

//Will create an item at objects location
function create_item(item, atObject, sideBounce, xoff, yoff) {
	
	var o	= instance_create_depth(atObject.x + xoff, 
									atObject.y + yoff, 
									0, 
									oItem);
	o.ID	= item;
	o.vspd	= -2;
	
	if (sideBounce) {
		o.hspd = random_range(-2, 2);
	}

	return(o);
}

//Used to check if an inventory has a spesific item
//Will return true or false if item is found
//Has the option to remove the amount of items if found 
function inv_has_item(target, item, remove, minimum) {
	if (has_inv(target)) {
		var i	= 0;
		var has = false;
		var pos = -1;
		repeat(ds_grid_height(target.inventory)) {
			if (target.inventory[# 0, i] = item) {
				has = true;
				pos = i;
				break;
			}
			i ++;
		}
		if (has) {
	
			if (!remove) {
				return(target.inventory[# inv.count, pos] >= minimum);
				exit;
			} else {
				if (target.inventory[# inv.count, pos] >= minimum) {
				
					target.inventory[# inv.count, pos] -= minimum;
	
					if (target.inventory[# inv.count, pos] < 1) {
						target.inventory[# inv.id, pos]	= -1;
						target.inventory[# inv.count, pos] = -1;		
					}	
					return(true);
				} else {
					return(false);	
				}
			}
	
		} else {
			return(false);	
		}
	}
}

//Will try to add an item to target inventory
//Will return true or false if taget has stored the new item
function inv_add_item(target, item) {
	if (variable_instance_exists(target, "inventory")) {
		var _inv	= target;
		var _item	= item;
		var _inv_free  = -1;
		var _inv_stack = -1;
	
		with(_inv) {
			var i=0;	
			repeat(ds_grid_height(_inv.inventory)) {
				if (_inv.inventory[# inv.id, i] = -1) {
					if ( _inv_free = -1) {
						_inv_free = i;
					}
				}
			
				if (_inv.inventory[# inv.id, i] = _item) {
					_inv_stack = i;
					break;
				}
			
				i++;
			}
		}
		if (_inv_stack != -1) {
			pickup = true;
			_inv.inventory[# inv.count, _inv_stack] += 1;
			return(true);
		} else if (_inv_free != -1){
			pickup = true;
			_inv.inventory[# inv.id, _inv_free] = _item;
			_inv.inventory[# inv.count, _inv_free] = 1;	
			return(true);
		} else {
			return(false);
		}	
	}
}

//Used to get the items name
//Change the ITEM_PREFIX macro to remove any part of naming conventions 
//you might have.
function item_get_name(sprite) {
	var item_name = sprite_get_name(sprite);
	var new_name = string_replace_all(item_name, ITEM_PREFIX, "");
	return(string_replace_all(new_name, "_", " "));
}
