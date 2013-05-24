function round5(x)
{
	return (x % 5) >= 2.5 ? parseInt(x / 5) * 5 + 5 : parseInt(x / 5) * 5;
} 

function startmenu(item){
	
	//collection info ophalen
	//naam rondje
	var naamrondje= item.name;
	//userid for image
	var user_id = item.userid;
	//description
	var description = item.description;
	//s3.amazonaws.com/noise.shoudio.com/avatars/{SIZING}/user_id.jpg
	var sizing = "100x100";
	var plaatje = '<img src="http://s3.amazonaws.com/noise.shoudio.com/avatars/'+sizing+'/'+ user_id+'.jpg" />';
	
	//determine rating
	var rating_rate_collect = Math.round(item.rating_rate * 10);
	var rating_rate = round5(rating_rate_collect);	
	var rating = '<span class="rating-static rating-'+rating_rate+'"></span>';


	// var zenden naar hTmL hak hak
 	$('.startmenu_naamrondje').append(naamrondje);
 	$('.startmenu_plaatje').append(plaatje);
 	//$('.startmenu_description').append(description);
 	$('.startmenu_rating').append(rating);
}

function startmenuHide() {
    $("#startmenu").fadeOut();
    showrightmenu();
}