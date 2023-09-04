import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTPlayer {
  // Change method name to 'videoPlayer' and add the return type 'Widget'
  Widget videoPlayer(String videoUrl) {
   print("video url"+videoUrl);
    String videoId = videoUrl.split('/').last.split('?').first;
    print("video id"+videoId);
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
      progressColors: const ProgressBarColors(
        playedColor: Colors.blueAccent,
        handleColor: Colors.blueAccent,
      ),
    );
  }

  
}
