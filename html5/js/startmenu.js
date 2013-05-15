 
function startmenu(item){
	
	//collection info ophalen
	//naam rondje
	var naamrondje= item.name;
	//plaatje
	var user_id = item.userid;
	//rating
	var rating_rate = item.rating_rate;
	var rating_votes = item.rating_votes;
	//omschrijving
	var description = item.description;
	
	//s3.amazonaws.com/noise.shoudio.com/avatars/{SIZING}/user_id.jpg
	var sizing = "100x100";
	var plaatje = '<img src="http://s3.amazonaws.com/noise.shoudio.com/avatars/'+sizing+'/'+ user_id+'.jpg" />';

	var rating = rating_rate+ "/5";

	// var zenden naar hTmL
 	$('.startmenu_naamrondje').append(naamrondje);
 	$('.startmenu_plaatje').append(plaatje);
 	$('.startmenu_description').append(description);
 	$('.startmenu_rating').append(rating);
}

function startmenuHide() {
    $("#startmenu").fadeOut();
    showrightmenu();
}