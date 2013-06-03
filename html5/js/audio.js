/*
=======================================================================
= 						Shoudio Audioplayer 						  =
=					  												  =
=======================================================================
 *       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 *       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 *	!!!!!!!IF YOU CHANGE TABS TO SPACES, YOU WILL BE KILLED!!!!!!!
 *       !!!!!!!!!!!!!!DOING SO FUCKS THE BUILD PROCESS!!!!!!!!!!!!!!!!
 *       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 *       !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

function changeVolume(value){
    $("#audio-player")[0].volume = value/100;
}

function showaudiowrapper() {
    $("#audiowrapper").animate({'margin-top':'266px'},1000);
    $("#imgclose").fadeIn(1000);
    
    $( "#volumediv" ).slider({
        value: 50,
        orientation: "horizontal",
        range: "min",
        animate: true,
        change: function(event, ui) {
            changeVolume(ui.value);
        }
    });
    
}

function hideaudiowrapper() {
    $("#audiowrapper").animate({'margin-top':'403px'},1000);
    $("#imgclose").fadeOut(1000);
	$("#audio-player")[0].currentTime = 0;
	audioPause();
}

function setMaxsec(){
	maxsec = $("#audio-player")[0].duration;
	$("#maxsec").text(timeConvert(maxsec));
    changeWaveLength();
    audioPlay();
}

function statusZero(){
    if(audioInterval!=null){ window.clearInterval(audioInterval); audioInterval = null;}
    changeWaveLength();
}

// sec omzetten naar HHMMSS
function timeConvert(time) {
    
    var sec_num = time;
    var hours   = Math.floor(sec_num / 3600);
    var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
    var seconds = Math.round(sec_num - (hours * 3600) - (minutes * 60));

    if (seconds == 60){
    	var seconds = 0;
    	minutes++;
    }

    if (hours   < 10) {hours   = "0"+hours;}
    if (minutes < 10) {minutes = "0"+minutes;}
    if (seconds < 10) {seconds = "0"+seconds;}

    //als er geen uren zijn haal hours weg
    if (00<hours){
    	var time    = hours+':'+minutes+':'+seconds;
    }else{
    	var time    = minutes+':'+seconds;
    }

    return time;
}

function changeWaveLength() {
    currenctsec = $("#audio-player")[0].currentTime;
    var procent = 100/maxsec * currenctsec;
    procent = procent * 4;
    $("#waveimg").css('width', procent + 'px');
    $("#currenctsec").text(timeConvert(currenctsec));
    if (currenctsec == maxsec) {
        $("#playbutton").css("display", "block");
        $("#pausebutton").css("display", "none");
        status = 0;
    }
}

function audioPlay() {
	$("#audio-player")[0].play();
	$("#playbutton").css("display", "none");
	$("#pausebutton").css("display", "block");
	status = 1;
	audioInterval = setInterval(changeWaveLength, 50);
}

function audioPause() {
		$("#audio-player")[0].pause();
        if(audioInterval != null) {
            window.clearInterval(audioInterval);
            audioInterval = null;
        }
        changeWaveLength();
        //css knoppen
		$("#playbutton").css("display", "block");
		$("#pausebutton").css("display", "none");
		status = 0;
}

function loadClickHandler(event) {
	var windowwidth = $("#rightmarkforwindowwidth").position().left/2-200;
		var locclick = event.pageX - windowwidth;
        $("#waveimg").css('width', locclick + 'px');
        $("#audio-player")[0].currentTime = (locclick / 400 * maxsec);
        $("#audio-player")[0].pause();

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
}