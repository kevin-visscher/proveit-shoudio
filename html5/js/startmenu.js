
function startmenu(item){
	
	//collection info ophalen
	var naamrondje= item.name;	
	var user_id = item.userid;
	var address =item.address;

	var createdon= item.created_on;
	var rating_rate = item.rating_rate;
	var rating_votes = item.rating_votes;
	
	//s3.amazonaws.com/noise.shoudio.com/avatars/{SIZING}/user_id.jpg
	var sizing = "100x100";
	var plaatje = '<img src="http://s3.amazonaws.com/noise.shoudio.com/avatars/'+sizing+'/'+ user_id+'.jpg" />';

	var rating = rating_rate+ "/5";

	// var zenden naar hTmL
 	$('.startmenu_naamrondje').append(naamrondje);
 	
 	$('.startmenu_plaatje').append(plaatje);
 	$('.startmenu_address').append(address);
 	
 	$('.startmenu_createdon').append(createdon);
 	$('.startmenu_rating').append(rating);

 	


}

