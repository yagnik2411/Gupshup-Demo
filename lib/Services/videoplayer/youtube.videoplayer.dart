import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YTPlayer {
  Widget videoPlayer(String videoUrl) {
    print("video url" + videoUrl);
    String videoId = videoUrl.split('/').last.split('?').first;
    print("video id" + videoId);
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

  Future<int?> getVideoDuration(String videoUrl) async {
    try {
      String videoId = videoUrl.split('/').last.split('?').first;

      var ytExplode = YoutubeExplode();
      var video = await ytExplode.videos.get(videoId);

      // Check if the video duration is available
      if (video.duration != null) {
        return video.duration!.inSeconds;
      }
    } catch (e) {
      print("Error getting video duration: $e");
    }

    return null;
    // Return null if the duration cannot be retrieved.
  }
}
