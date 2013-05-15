	var currenctsec = 0;
	var maxsec = 0;

	$(document).ready(function(){

		$("#playbutton").click(function(){
			$("#audio-player")[0].play();
			$("#message").text("Music started");
			$("#playbutton").css("display", "none");
			$("#pausebutton").css("display", "block");
			maxsec = $("#audio-player")[0].duration;

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
            var time = locclick / 400 / 100 * maxsec;
            $("#audio-player")[0].currentTime = time;
        });


		$("#pausebutton").click(function(){
			$("#audio-player")[0].pause();
			$("#message").text("Music paused");
			$("#playbutton").css("display", "block");
			$("#pausebutton").css("display", "none");
		})
 
		$("#stop-bt").click(function(){
			$("#audio-player")[0].pause(); 
			$("#audio-player")[0].currentTime = 0;
			alert($("#audio-player")[0].currentTime);
			$("#message").text("Music Stopped");
		})

		/*
		//var duur = audio-player.duration;
		//$(".songtime").html(duration);
		


		$("#audio-player").on("Canplay", function () {
       	var currenctsec = this.currentTime;
       	var maxsec =

       	$("#songtime").text();
    	});

		});
	*/
	})