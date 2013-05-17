/*
========================
= Shoudio audio-player =
=					   =
========================
*/

var currenctsec = 0;
var maxsec = 60000;
var status = 0;

// sec omzetten naar HHMMSS
//String.prototype.toHHMMSS = function () {
function timeConvert(time) {
    
    var sec_num = time;
    var hours   = Math.floor(sec_num / 3600);
    var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    var seconds = Math.round(sec_num - (hours * 3600) - (minutes * 60));

    if (hours   < 10) {hours   = "0"+hours;}
    if (minutes < 10) {minutes = "0"+minutes;}
    if (seconds < 10) {seconds = "0"+seconds;}

    if (00<hours){
    	var time    = hours+':'+minutes+':'+seconds;
    }else{
    	var time    = minutes+':'+seconds;
    }

    return time;
}
//alert(timeConvert(maxsec));

$(document).ready(function(){

	// playbutton
	$("#playbutton").click(function(){
		$("#audio-player")[0].play();
		$("#playbutton").css("display", "none");
		$("#pausebutton").css("display", "block");
		maxsec = $("#audio-player")[0].duration;
		$("#maxsec").text(timeConvert(maxsec));
		status = 1;


		setInterval(function() {
			currenctsec = $("#audio-player")[0].currentTime;
			var procent = 100/maxsec * currenctsec;
			procent = procent * 4;
			$("#waveimg").css('width', procent + 'px');
			$("#currenctsec").text(timeConvert(currenctsec));
		}, 10);		

	})
	// progress bar
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

	// pausebutton
	$("#pausebutton").click(function(){
		$("#audio-player")[0].pause();
		//css knoppen
		$("#playbutton").css("display", "block");
		$("#pausebutton").css("display", "none");
		status = 0;
	})

	// stopbutton
	$("#stop-bt").click(function(){
		$("#audio-player")[0].pause(); 
		$("#audio-player")[0].currentTime = 0;
		//css knoppen
		$("#playbutton").css("display", "block");
		$("#pausebutton").css("display", "none");
		status = 0;
	})


// hack hack	
})
