	$(document).ready(function(){
		$("#playbutton").click(function(){
			$("#audio-player")[0].play();
			$("#message").text("Music started");
			$("#playbutton").css("display", "none");
			$("#pausebutton").css("display", "block");
		})
 
		$("#pausebutton").click(function(){
			$("#audio-player")[0].pause();
			$("#message").text("Music paused");
			$("#playbutton").css("display", "block");
			$("#pausebutton").css("display", "none");

		})
 
		$("#stop-bt").click(function(){
			$("#audio-player")[0].pause();
			$("#audio-player")[0].currentTime = 0;
			$("#message").text("Music Stopped");
		})
	})