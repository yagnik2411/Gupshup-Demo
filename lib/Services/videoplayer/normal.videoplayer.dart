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
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}
