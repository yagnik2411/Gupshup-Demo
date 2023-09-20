import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class YouTubeLikeVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const YouTubeLikeVideoPlayer({required this.videoUrl, Key? key}) : super(key: key);

  @override
  _YouTubeLikeVideoPlayerState createState() => _YouTubeLikeVideoPlayerState();

  Future<int> getVideoDurationInSeconds(
      VideoPlayerController controller) async {
    await controller.initialize();
    final duration = controller.value.duration;
    return duration.inSeconds;
  }
}

class _YouTubeLikeVideoPlayerState extends State<YouTubeLikeVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        _controller.pause();
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<int> getVideoDurationInSeconds() async {
    await _controller.initialize();
    final duration = _controller.value.duration;
    return duration.inSeconds;
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _TimelineBar(controller: _controller),
                  _ControlsOverlay(
                    isPlaying: _isPlaying,
                    onPlayPause: _togglePlayPause,
                  ),
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}

class _TimelineBar extends StatelessWidget {
  final VideoPlayerController controller;

  const _TimelineBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: true,
      colors: const VideoProgressColors(
        playedColor: Colors.blue,
        bufferedColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const _ControlsOverlay({
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isPlaying ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: onPlayPause,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 32,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
