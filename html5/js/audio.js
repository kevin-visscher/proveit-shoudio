/*
========================
= Shoudio audio-player =
=					   =
========================
*/

var currenctsec = 0;
var maxsec = 0;
var status = 0;

function changeVolume(value){
    $("#audio-player")[0].volume = (value / 100);
}

$(document).ready(function(){

	$("#playbutton").click(function(){
		$("#audio-player")[0].play();
		$("#playbutton").css("display", "none");
		$("#pausebutton").css("display", "block");
		maxsec = $("#audio-player")[0].duration;
		status = 1;


		setInterval(function() {
			currenctsec = $("#audio-player")[0].currentTime;
			var procent = 100/maxsec * currenctsec;
			procent = procent * 4;
			$("#waveimg").css('width', procent + 'px');
		}, 10);		

	})

	$("#loadclickhandler").bind("click", function(event){
		var windowwidth = $("#rightmarkforwindowwidth").position().left/2-200;
		var locclick = event.pageX - windowwidth;
        $("#waveimg").css('width', locclick + 'px');
        $("#audio-player")[0].currentTime = (locclick / 400 * maxsec);
        $("#audio-player")[0].pause();
        //css knoppen

	  if (status == 1) {
	    $("#audio-player")[0].play();
		$("#playbutton").css("display", "none");
		$("#pausebutton").css("display", "block");

	  } else {
	     $("#audio-player")[0].pause();
		//css knoppen
		$("#playbutton").css("display", "block");
		$("#pausebutton").css("display", "none");
	  }

		//$("#playbutton").css("display", "block");
		//$("#pausebutton").css("display", "none");
    });


	$("#pausebutton").click(function(){
		$("#audio-player")[0].pause();
		//css knoppen
		$("#playbutton").css("display", "block");
		$("#pausebutton").css("display", "none");
		status = 0;
	})

	$("#stop-bt").click(function(){
		$("#audio-player")[0].pause(); 
		$("#audio-player")[0].currentTime = 0;
		//css knoppen
		$("#playbutton").css("display", "block");
		$("#pausebutton").css("display", "none");
		status = 0;
	})

	$("#sliders").slider({
	    value : 75,
	    step  : 1,
	    range : 'min',
	    min   : 0,
	    max   : 100,
	    slide : function(){
	        //var value = $("#slider").slider("value");
	        //$("#audio-player")[0].volume = (value / 100);
	        alert(maxsec);
	    }
	});

// hack hack	
})
