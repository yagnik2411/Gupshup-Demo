import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NormalVideoPlayer extends StatefulWidget {
  final String videoUrl;

  NormalVideoPlayer({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _NormalVideoPlayerState createState() => _NormalVideoPlayerState();
}

class _NormalVideoPlayerState extends State<NormalVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        // Pause the video initially
        _controller.pause();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playPauseVideo() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        SizedBox(height: 10.0), // Add some spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              splashColor: Colors.blueAccent,
              splashRadius: 20,
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.blue,
              ),
              onPressed: _playPauseVideo,
            ),
          ],
        ),
      ],
    );
  }
}
