
function startmenu(item){
	
	//collection info ophalen
	var address =item.address;
	var naamrondje= item.name;	
	var createdon= item.created_on;
	var user_id = item.userid;
	var description= item.description;
	
	//s3.amazonaws.com/noise.shoudio.com/avatars/{SIZING}/user_id.jpg
	var sizing = "100x100";
	var plaatje = '<img src="http://s3.amazonaws.com/noise.shoudio.com/avatars/'+sizing+'/'+ user_id+'.jpg" />';


	// var zenden naar hTmL
 	$('.startmenu_address').append(address);
 	$('.startmenu_naamrondje').append(naamrondje);
 	$('.startmenu_createdon').append(createdon);
 	$('.startmenu_plaatje').append(plaatje);
 	$('.startmenu_description').append(description);

 	


}

