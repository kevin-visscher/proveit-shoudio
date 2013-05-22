 
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
	//rating
	var rating_rate = Math.round(item.rating_rate * 10)/10;
	//determine rating
	if (rating_rate>4.5)
	{
		var rating = '<span class="rating-static rating-50"></span>';
	}
	else if(rating_rate>4 && rating_rate<=4.5)
	{
		var rating = '<span class="rating-static rating-45"></span>';
	}
	else if(rating_rate>3.5 && rating_rate<=4)
	{
		var rating = '<span class="rating-static rating-40"></span>';
	}
	else if(rating_rate>3 && rating_rate<=3.5)
	{
		var rating = '<span class="rating-static rating-35"></span>';
	}
	else if(rating_rate>2.5 && rating_rate<=3)
	{
		var rating = '<span class="rating-static rating-30"></span>';
	}
	else if(rating_rate>2 && rating_rate<=2.5)
	{
		var rating = '<span class="rating-static rating-25"></span>';
	}
	else if(rating_rate>1.5 && rating_rate<=2)
	{
		var rating = '<span class="rating-static rating-20"></span>';
	}
	else if(rating_rate>1 && rating_rate<=1.5)
	{
		var rating = '<span class="rating-static rating-15"></span>';
	}
	else if(rating_rate>0.5 && rating_rate<=1)
	{
		var rating = '<span class="rating-static rating-10"></span>';
	}
	else
	{
		var rating = '<span class="rating-static rating-5"></span>';
	}

	// var zenden naar hTmL hak hak
 	$('.startmenu_naamrondje').append(naamrondje);
 	$('.startmenu_plaatje').append(plaatje);
 	$('.startmenu_description').append(description);
 	$('.startmenu_rating').append(rating);
}

function startmenuHide() {
    $("#startmenu").fadeOut();
    showrightmenu();
}