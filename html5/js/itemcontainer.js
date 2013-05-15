function onYouTubeIframeAPIReady() {
    alert("ready");
}

//The youtube API will call this function when the video player is ready.
function onPlayerReady(event) {
    event.target.playVideo();
}

function stopVideo() {
    youtubePlayer.stopVideo();
}