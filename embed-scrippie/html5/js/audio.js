/*
* Function volume of the audioplayer
* 
* @param (value) get from 
*/
function changeVolume(value){
    $("#audio-player")[0].volume = value/100;
}

/*
* Function will show the audioplayer with animate
* 
*/
function showaudiowrapper() {
    $("#audiowrapper").animate({'margin-top':'266px'},350);
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

/*
* Function will hide the audioplayer with animate
* 
*/
function hideaudiowrapper() {
    $("#audiowrapper").animate({'margin-top':'403px'},350);
    $("#imgclose").fadeOut(1000);
	$("#audio-player")[0].currentTime = 0;
	audioPause();
}

/*
* function will set max sec when audio is loaded
*  and autoplay the audio
*/
function setMaxsec(){
	maxsec = $("#audio-player")[0].duration;
	$("#maxsec").text(timeConvert(maxsec));
    changeWaveLength();
    audioPlay();
}

/*
* 
*/
function statusZero(){
    if(audioInterval!=null){ window.clearInterval(audioInterval); audioInterval = null;}
    changeWaveLength();
}

/*
* Function timeconvert convert int into hh:mm:ss
* 
* @param (time) is amount of seconds
*/
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

/*
* Function play audio and change playbutton into pausebutton
* 
*/
function audioPlay() {
	$("#audio-player")[0].play();
	$("#playbutton").css("display", "none");
	$("#pausebutton").css("display", "block");
	status = 1;
	audioInterval = setInterval(changeWaveLength, 50);
}

/*
* Function play audio and change pausebutton into playbutton 
*  and stop interval
*/
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

/*
* Function change wave where is clicked
*  if audio is played it continues to play
*  when paused it remain paused
*
* @param (event) is cordination where is clicked
*/
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

/*
* Function fill in the wavelength when audio play
* 
*/
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
